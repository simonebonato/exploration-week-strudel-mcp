# Strudel MCP in Claude Code

**Status: ✅ verified 2026-07-01 — including real audio end-to-end.**

## Setup in 3 steps

```bash
# 1. One-time install (skip if done)
npm install -g @williamzujkowski/live-coding-music-mcp@4.0.0
npx playwright install chromium

# 2. Register the server
claude mcp add strudel live-coding-music-mcp

# 3. Confirm
claude mcp list          # expect: strudel ... ✔ Connected
```

> [!NOTE]
> **Scope:** the default registration is **local** (this project folder only, written to
> `~/.claude.json`). For a demo you run from anywhere, use:
> `claude mcp add --scope user strudel live-coding-music-mcp`

## Use it

> [!IMPORTANT]
> Tools load at **session start** → open a **NEW** Claude Code session after registering.

Then just ask:

| You type | What happens |
| --- | --- |
| "Initialize Strudel." | Chromium opens at strudel.cc (`init`) |
| "Play a four-on-the-floor kick." | pattern written + played (`edit_pattern`, `playback`) |
| "Add a hi-hat and set the tempo to 128." | layer added (`edit_pattern`, `set_tempo`) |
| "Stop." | silence (`playback`) |

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| Tools don't appear | Restart Claude Code (tools load at session start) |
| `not Connected` in `mcp list` | `which live-coding-music-mcp` → reinstall if missing |
| Windows: server won't start | Register as `claude mcp add strudel -- cmd /c live-coding-music-mcp` ([why](./service-setup-summary.md)) |
| Browser opens, **no sound** | Click once inside the Chromium window (audio needs a user gesture) |
| Remove it | `claude mcp remove strudel` |

## Reference

- Claude Code MCP docs: <https://docs.claude.com/en/docs/claude-code/mcp>
