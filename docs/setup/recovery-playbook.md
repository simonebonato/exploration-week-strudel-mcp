# Recovery Playbook — "if X breaks live → do Y"

One page to glance at when something dies during the workshop. **Status: stub** — fill in
the "verified fix" column as failures are actually hit during testing (Mac test 2026-08-18,
Windows dry-run, rehearsal). Don't ship this to students until each row has been exercised.

| Symptom | First move | Verified fix / notes |
| --- | --- | --- |
| Chromium window closed / crashed mid-session | Ask the agent: "Initialize Strudel again" (`init` relaunches the browser) | ⬜ to verify |
| Browser open, pattern playing, **no sound** | Click once inside the Chromium window (audio needs a user gesture); check OS volume/output device | ⬜ to verify |
| Agent changed the code, **music didn't change** | Press **`update`** top right in strudel.cc (or Ctrl/Cmd+Enter) — [screenshot](../assets/strudel-update-button.png) | ✅ hit + fixed 2026-08-18 |
| Client shows server **not connected** | `which live-coding-music-mcp` (Win: `where`); reinstall `@4.0.0` if missing; restart the client (tools load at session start) | ⬜ to verify |
| Windows: server fails to spawn at all | `.cmd` shim issue → re-register wrapped in `cmd /c` (see [service-setup-summary](./service-setup-summary.md)) | ⬜ to verify |
| Antigravity free quota exhausted | Expected failure mode (hit 2026-07-01). Backup plan TBD at 2026-08-19 meeting — see `logs/meeting-2026-08-19-open-failure-points.md` | ⬜ decision pending |
| Agent loops / fumbles multi-step tool calls | Give one small instruction at a time ("init", then "play a kick") instead of a compound request | ⬜ to verify |
| strudel.cc unreachable (venue Wi-Fi) | Works as a PWA after first load — pre-load it on each machine during the on-day check | ⬜ to verify |
| Two Chromium windows fighting | Two clients running → each spawns its own server. Quit one client; one client at a time per machine | ✅ known behavior |
