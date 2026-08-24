# Recovery Playbook — "if X breaks live → do Y"

One page to glance at when something dies during the workshop. **Status: stub** — fill in
the "verified fix" column as failures are actually hit during testing (Mac test 2026-08-18,
Windows smoke-test 2026-08-24, rehearsal). Don't ship this to students until each row has
been exercised.

| Symptom | First move | Verified fix / notes |
| --- | --- | --- |
| **Chromium window closed** / crashed mid-session — every tool returns `Target page, context or browser has been closed` | **Reconnect the MCP server in your client** (`/mcp` in Claude Code). Do **not** bother asking the agent to initialize again | ✅ hit twice + fixed 2026-08-21. **`init` does NOT recover this** — it returns `"Already initialized"` and relaunches nothing. `session create` times out, `session destroy` says the default session doesn't exist, `browser_window show` fails. Client-side reconnect is the only fix. [Evidence](../../logs/prompt-test-2026-08-21.md#a--the-browser-session-dies-and-nothing-in-the-server-recovers-it) |
| Agent insists everything is fine but nothing plays | Same as above — check whether `init` says `"Already initialized"` when you expected a fresh launch. That string **is** the symptom | ✅ 2026-08-21. `diagnostics` reports `initialized: true` (and even `playing: true`) from cache while the browser is dead. **Don't trust it to tell you the session is alive** |
| Browser open, pattern playing, **no sound** | Click once inside the Chromium window (audio needs a user gesture); check OS volume/output device | ⬜ to verify |
| Agent changed the code, **music didn't change** | Press **`update`** top right in strudel.cc (or Ctrl/Cmd+Enter) — [screenshot](../assets/strudel-update-button.png) | ✅ hit + fixed 2026-08-18 |
| Client shows server **not connected** | `which live-coding-music-mcp` (Win: `where`); reinstall `@4.0.0` if missing; restart the client (tools load at session start) | ⬜ to verify |
| Windows: server fails to spawn, or **times out** | `.cmd` shim bug (open upstream in both clients). Re-register with **absolute `node` + absolute `dist/index.js`** — see [service-setup-summary](./service-setup-summary.md). `cmd /c` is NOT a reliable fix | ✅ 2026-08-24 — absolute-`node` form verified on real Windows hardware for Claude Code and Codex |
| Server starts but can't find a browser | `npx playwright install` downloaded a mismatched revision. Re-run using the server's **bundled** playwright CLI | ⬜ to verify |
| Student's plan/quota runs out mid-session | FHNW-funded plans (decided 2026-08-20). If it still happens: pair them with a neighbour — two people on one laptop is a fine creative setup | ⬜ to verify |
| Agent produces something that isn't what was asked | Don't restart — ask it *"that's not X, what's missing?"*. Self-diagnosis is a better teaching moment than the happy path | ⬜ to verify |
| Student says "it sounds bad" and the agent flails | Teach the fix in place: describe, don't evaluate. See [prompts.md](../strudel/prompts.md#the-thing-you-must-know-your-agent-cannot-hear-it) | ✅ by design |
| Agent loops / fumbles multi-step tool calls | Give one small instruction at a time ("init", then "play a kick") instead of a compound request | ⬜ to verify |
| strudel.cc unreachable (venue Wi-Fi) | Works as a PWA after first load — pre-load it on each machine during the on-day check | ⬜ to verify |
| Two Chromium windows fighting | Two clients running → each spawns its own server. Quit one client; one client at a time per machine | ✅ known behavior |
