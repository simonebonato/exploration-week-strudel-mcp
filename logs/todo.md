# TODO — running task log

Status legend: [ ] todo · [~] in progress · [x] done · [!] blocked

## Slice 1 — Bring-up (install + prove sound)
- [x] Verify Node 22+ (v22.22.2 ✅)
- [x] `npm install -g @williamzujkowski/live-coding-music-mcp`
- [x] `npx playwright install chromium` (Chromium 1228)
- [x] Audio smoke test: played beat via MCP; `analyze` confirmed isPlaying/isSilent=false,
      bass energy at ~86Hz (the kick). Full chain MCP→browser→sound WORKS. (2026-07-01)

## Slice 2 — Claude Code integration
- [x] `claude mcp add strudel live-coding-music-mcp`
- [x] Health check: Connected ✅
- [ ] Confirm tools callable from a fresh session (play a pattern from Claude Code)
- [ ] Write student-facing doc: `docs/setup/claude-code.md`  (drafted, verify live)

## Slice 3 — Codex integration
- [x] Confirm Codex CLI installed + version (codex-cli 0.137.0)
- [x] `codex mcp add strudel -- live-coding-music-mcp` (wrote to dotfiles config.toml)
- [x] `codex mcp list` shows strudel `enabled`
- [ ] Verify tools callable from Codex; play a pattern (live, not yet done)
- [x] Write doc: `docs/setup/codex.md`
- [ ] Decide: keep the `[mcp_servers.strudel]` block in dotfiles, or move to project-scoped

## Slice 4 — Google leg: Antigravity CLI (was Gemini CLI)
- [x] Decision: use Antigravity CLI (Gemini CLI deprecated for free tier 2026-06-18)
- [x] Confirmed Antigravity CLI is free + supports MCP
- [x] Found config format: `~/.gemini/config/mcp_config.json` (mcpServers object)
- [x] Write doc: `docs/setup/antigravity-cli.md` (drafted)
- [x] Install Antigravity CLI on this machine + sign in (free Google account) — cmd: `agy`
- [x] Add strudel server to `~/.gemini/config/mcp_config.json`
- [x] Verify tools listed from Antigravity (`agy -p`) — all 26 strudel tools present ✅
- [ ] Play a pattern from Antigravity to confirm audio (only tool-listing done so far)

## Slice 5 — Knowledge base
- [x] Strudel concept primer → docs/strudel/primer.md
- [x] 5 tested demo patterns → docs/strudel/demo-patterns.md (4 local-valid, 1 runtime-valid)
- [x] A clear "story" for the session (build a beat live, step by step) → in demo-patterns.md
- [ ] Optional: play-test patterns 3,4,5 for sound quality (only #2 heard so far)

## Slice 5b — Free / local options for students (so nobody must pay)
- [x] Log the Gemini free-quota exhaustion (2026-07-01) → logs/costs-and-quota.md
- [x] Research free/local MCP clients → docs/setup/free-and-local-options.md
- [ ] TEST one local path end-to-end: Ollama + Goose (or ollmcp), tool-calling model
      (e.g. qwen2.5), register `live-coding-music-mcp`, confirm it can init + play a pattern
- [ ] Note in the doc how reliable the local model actually was at multi-step tool calls
- [ ] (optional) Verify whether Antigravity `agy` accepts a pay-as-you-go API key

## Slice 6 — Rehearsal + recovery
- [ ] Full dry-run of the session flow, on the actual demo machine, in each client
- [ ] Document rough edges hit + quick recovery steps
- [ ] Decide the exact live script (what to type, expected sound at each step)

## Open questions to resolve before the session
- [ ] Which machine hosts the demo? (verify audio activation there)
- [x] Is Codex CLI installed? Yes — 0.137.0, strudel registered.
- [x] Is Gemini CLI installed? No — and it's deprecated for free tier → Antigravity CLI.
- [ ] Install + sign into Antigravity CLI (free Google account).
- [ ] Do we want the `ai_assist` tool (needs a Gemini API key)? Optional.
- [ ] What should STUDENTS install themselves vs. just watch? (shapes docs/setup)
