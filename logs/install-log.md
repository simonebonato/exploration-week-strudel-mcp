# Install Log

Chronological record of what was actually done. Newest at bottom.

---

## 2026-07-01 — Slice 1 (bring-up) + Slice 2 (Claude Code)

**Machine:** macOS (Darwin 25.5.0), Node v22.22.2 (via nvm), npm 10.9.7.

### Steps run

```bash
# 1. Install the MCP server globally
npm install -g @williamzujkowski/live-coding-music-mcp
# -> added 186 packages in 8s
# -> bin at: ~/.nvm/versions/node/v22.22.2/bin/live-coding-music-mcp

# 2. Install the browser Playwright drives
npx playwright install chromium
# -> installed playwright 1.61.1 + Chromium build 1228
#    (browsers cached in ~/Library/Caches/ms-playwright/)

# 3. Wire into Claude Code
claude mcp add strudel live-coding-music-mcp
# -> Added stdio MCP server "strudel" to local config
#    (written to ~/.claude.json, scoped to this project)

# 4. Health check
claude mcp list
# -> strudel: live-coding-music-mcp - ✔ Connected
```

### Verifications

- ✅ `live-coding-music-mcp` bin on PATH.
- ✅ Server bundles Playwright **1.61.1**; globally-installed Chromium is build **1228** —
  versions match (no mismatch gotcha).
- ✅ Claude Code health check: **Connected**.

### Notes / gotchas

- `npx playwright install chromium` prints a scary "install your project's dependencies
  first" warning. **Harmless here** — we're installing browsers for a global tool, not a
  local project. Chromium still downloads correctly.
- MCP tools load at **session start**. After `claude mcp add`, the current Claude Code
  session does NOT hot-reload the tools — start a new session to use them.
- Package name matters: use `@williamzujkowski/live-coding-music-mcp` (v4.x). The older
  `@williamzujkowski/strudel-mcp-server` (v2.4.1) is stale.

### 2026-07-01 — Environment findings (Codex + Gemini)

- **Codex CLI installed:** `codex-cli 0.137.0`. Supports `codex mcp add/list/get/remove`.
  ⚠️ `~/.codex/config.toml` is a **symlink into the user's dotfiles repo**
  (`~/dotfiles/ai/codex/config.toml`). Adding an MCP there edits a version-controlled file.
  Consider a project-scoped `.codex/config.toml` instead to avoid touching dotfiles.
- **Gemini CLI NOT installed** on this machine.
- **Gemini pricing/status (verified vs official geminicli.com):**
  - Free with a personal Google account (~60 req/min, 1000 req/day). No paid sub needed.
  - Since **2026-03-25**: free tier limited to **Flash** models (no Pro). Fine for MCP.
  - ⚠️ Official banner: *"Unpaid tier and Google One users: Gemini CLI will be replaced by
    **Antigravity CLI** on June 18th."* That date has passed (today 2026-07-01). For a free
    account, the Google-side demo client is likely **Antigravity CLI** now, not Gemini CLI.
  - DECISION NEEDED: keep Gemini CLI, switch the Google leg to Antigravity CLI, or drop it.

### 2026-07-01 — Slice 3 (Codex) done + Google leg decided

```bash
codex mcp add strudel -- live-coding-music-mcp
# -> "Added global MCP server 'strudel'."
codex mcp list
# -> strudel  live-coding-music-mcp  enabled
```

- ✅ Codex `strudel` server registered and `enabled`.
- ⚠️ It wrote `[mcp_servers.strudel]` into `~/.codex/config.toml`, which is a **symlink into
  the dotfiles repo**. The file already had unrelated uncommitted drift (project trust
  entries, a `gpt-5.5` nux counter Codex writes on its own). Our only intentional change is
  the `[mcp_servers.strudel]` block. **Nothing committed.**

**Google leg decision:** switch from Gemini CLI to **Antigravity CLI** (free successor;
Gemini CLI deprecated for free/unpaid accounts 2026-06-18). Antigravity CLI is free and
supports MCP. Config file: `~/.gemini/config/mcp_config.json` with a standard `mcpServers`
object (strict JSON, no comments). Antigravity CLI **not yet installed** here — guide
drafted in `docs/setup/antigravity-cli.md`, verify live before the session.

### 2026-07-01 — Slice 5 (knowledge base) + audio proven

- **Audio smoke test PASSED.** Played the basic beat via `edit_pattern(auto_play)`;
  `analyze` returned `isPlaying:true, isSilent:false`, bass 217 @ ~86Hz (kick). The full
  chain MCP → Chromium → strudel.cc → sound works.
- Wrote `docs/strudel/primer.md` and `docs/strudel/demo-patterns.md` (5 patterns + a live
  script). 4 patterns pass local validation; the `.scale()` melody passes only *runtime*
  validation.
- **Rough edges found (for the rehearsal playbook):**
  1. `validate_pattern_local` uses a stripped in-process engine — it wrongly rejects
     `.scale()` ("n(...).scale is not a function"). Use `validate_pattern_runtime` for
     anything beyond basics; the real strudel.cc accepts it.
  2. `playback stop` failed once with "Target page/browser has been closed" — the Chromium
     window had been closed underneath the server. Recovery: call `init` again to relaunch.
     Lesson: don't close the browser window mid-demo; if it dies, re-`init`.

### 2026-07-01 — Slice 4 (Antigravity CLI) verified

- Antigravity CLI installed by the user. Command is **`agy`** (`~/.local/bin/agy`).
  No `agy mcp` subcommand — MCP is file-configured only.
- Wrote `~/.gemini/config/mcp_config.json` (was empty) with the `strudel` stdio server.
- Verified: `agy -p "list your strudel MCP tools"` → "Yes." + full 26-tool list.
- **All three clients now see the server:** Claude Code (connected + audio played),
  Codex (enabled), Antigravity (tools listed). Hard requirement met at the connection level.

### Not yet done

- Play a pattern *from Codex and from Antigravity* to confirm audio there too (only Claude
  Code has produced sound so far).
- Slice 6: full rehearsal + recovery playbook on the demo machine. (`init` → play a pattern → hear sound). Needs a fresh Claude Code
  session OR a direct stdio test script. Opens a visible Chromium window and makes noise.
- Codex integration (slice 3).
- Gemini CLI integration (slice 4).
- Knowledge base + demo patterns (slice 5).
- Rehearsal + recovery playbook (slice 6).

---

## 2026-08-18 — Sandbox smoke test (fresh-environment simulation)

Simulated a clean student machine per client via fake `HOME` dirs (no VM needed),
script: `scripts/sandbox-smoke-test.sh`.

| Layer | What | Result |
| --- | --- | --- |
| 0 | Raw MCP handshake, no AI: `npx @modelcontextprotocol/inspector --cli live-coding-music-mcp --method tools/list` | ✅ **26 tools** (exact count; docs said "~27") |
| 1 | Claude Code, fresh HOME: `mcp add` + `mcp list` health check (real handshake, 0 tokens) | ✅ Connected |
| 1 | Codex, fresh CODEX_HOME: `mcp add` + `mcp list` (static check, 0 tokens) | ✅ enabled, correct config.toml |
| 2 | Codex e2e, fresh config + copied auth, `codex exec -m gpt-5.4-mini` | ✅ saw the strudel tools (model said "27" — mini-model miscount, ground truth 26) |
| — | Antigravity sandbox | ❌ **not sandboxable**: Google OAuth is interactive, token not in plain HOME files (full state-dir copy still triggered re-auth) |
| — | Antigravity real env (free tier): `agy -p` tool check | ✅ strudel tools present (Flash reported "20" — likely truncated/miscounted listing; 26 were confirmed 2026-07-01) |

Gotchas learned:
- Codex needs `CODEX_HOME` to point at an **existing** dir, or it errors.
- `codex mcp list` does NOT spawn/handshake the server — "enabled" is read from config.
  Only Claude Code's `mcp list` proves a real connection for free.
- `gpt-5.1-codex-mini` rejected on a ChatGPT account; available slugs here:
  gpt-5.4, gpt-5.4-mini, gpt-5.5. Used gpt-5.4-mini.
- These sandbox tests cover **registration + spawn + tools**, not audio — the browser/
  sound leg still needs the manual per-client test.
