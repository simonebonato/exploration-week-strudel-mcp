#!/usr/bin/env bash
# Sandbox smoke test for the Strudel MCP setup — no real configs touched.
#
# Each client gets a FRESH fake HOME in a temp dir, then we follow the student
# setup steps exactly and verify the server registers/connects.
#
# Layers (cheap → less cheap):
#   0. Raw MCP handshake (no AI client, no tokens):  tools/list via MCP Inspector
#   1. Claude Code: register + `mcp list` health check (real handshake, no tokens)
#   2. Codex: register + one tiny prompt on the mini model (needs auth copied in;
#      costs a few cents — enable with --codex-e2e)
#
# Antigravity CLI cannot be sandbox-tested: its Google OAuth is interactive and
# not stored in plain HOME files. Test it in the real environment:
#   agy -p "List your strudel MCP tools."
#
# Verified working on macOS 2026-08-18 (see logs/install-log.md).

set -euo pipefail

SBX="$(mktemp -d /tmp/strudel-mcp-sandbox.XXXXXX)"
CODEX_E2E=false
[[ "${1:-}" == "--codex-e2e" ]] && CODEX_E2E=true

echo "Sandbox: $SBX"
cleanup() { rm -rf "$SBX"; }   # also removes any copied auth
trap cleanup EXIT

fail=0

echo
echo "=== Layer 0: raw MCP handshake (no AI, no tokens) ==="
if npx -y @modelcontextprotocol/inspector --cli live-coding-music-mcp \
    --method tools/list 2>/dev/null \
  | python3 -c "import json,sys; d=json.load(sys.stdin); n=len(d['tools']); print(f'   {n} tools listed'); sys.exit(0 if n>=20 else 1)"; then
  echo "   PASS: server speaks MCP and lists its tools"
else
  echo "   FAIL: server did not answer tools/list"; fail=1
fi

echo
echo "=== Layer 1: Claude Code in a fresh HOME (no tokens) ==="
mkdir -p "$SBX/claude-home"
( cd "$SBX/claude-home"
  HOME="$SBX/claude-home" claude mcp add strudel live-coding-music-mcp >/dev/null
  if HOME="$SBX/claude-home" claude mcp list 2>&1 | grep -q "strudel.*Connected"; then
    echo "   PASS: fresh-config Claude Code registers + connects"
  else
    echo "   FAIL: strudel not Connected in fresh Claude Code"; exit 1
  fi
) || fail=1

echo
echo "=== Layer 1: Codex registration in a fresh CODEX_HOME (no tokens) ==="
mkdir -p "$SBX/codex-home/.codex"
( cd "$SBX/codex-home"
  export HOME="$SBX/codex-home" CODEX_HOME="$SBX/codex-home/.codex"
  codex mcp add strudel -- live-coding-music-mcp >/dev/null
  if codex mcp list 2>&1 | grep -q "strudel.*enabled"; then
    echo "   PASS: fresh-config Codex registers (config.toml written)"
    echo "   NOTE: 'enabled' is static — real spawn needs --codex-e2e"
  else
    echo "   FAIL: strudel not enabled in fresh Codex"; exit 1
  fi
) || fail=1

if $CODEX_E2E; then
  echo
  echo "=== Layer 2: Codex end-to-end on mini model (few cents) ==="
  cp "$HOME/.codex/auth.json" "$SBX/codex-home/.codex/auth.json"
  ( cd "$SBX/codex-home"
    export HOME="$SBX/codex-home" CODEX_HOME="$SBX/codex-home/.codex"
    out=$(codex exec -m gpt-5.4-mini --skip-git-repo-check -s read-only \
      "Reply with one line: how many tools the strudel MCP server exposes and the first three names. Do not call any tools." \
      2>/dev/null | awk 'length($0)<500' | tail -3)
    echo "   Codex says: $out"
    if echo "$out" | grep -qi "strudel"; then
      echo "   PASS: Codex spawned the server and saw its tools"
    else
      echo "   FAIL: Codex answer does not mention strudel tools"; exit 1
    fi
  ) || fail=1
fi

echo
[[ $fail -eq 0 ]] && echo "ALL PASSED ✅" || { echo "SOME LAYERS FAILED ❌"; exit 1; }
