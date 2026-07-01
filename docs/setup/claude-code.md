# Strudel MCP in Claude Code  ✅ verified 2026-07-01

## 1. One-time install (if not done yet)

```bash
npm install -g @williamzujkowski/live-coding-music-mcp
npx playwright install chromium
```

## 2. Register the server with Claude Code

```bash
claude mcp add strudel live-coding-music-mcp
```

This writes the server to your Claude Code config (`~/.claude.json`), scoped to the current
project folder.

Scope options:
- default (above) = **local**, only this project.
- `claude mcp add --scope user strudel live-coding-music-mcp` = available in **all**
  projects. Handy for a demo you run from anywhere.

## 3. Confirm it connected

```bash
claude mcp list
```

Expected:

```
strudel: live-coding-music-mcp - ✔ Connected
```

## 4. Use it

**Start a NEW Claude Code session** (tools load at session start — a server added
mid-session won't appear until you restart).

Then just ask, e.g.:

- "Initialize Strudel." → opens a Chromium window at strudel.cc.
- "Play a simple four-on-the-floor kick pattern."
- "Add a hi-hat and set the tempo to 128."
- "Stop."

Under the hood Claude calls tools like `init`, `edit_pattern`, `playback`, `set_tempo`.

## Troubleshooting

| Symptom | Fix |
|---|---|
| Tools don't appear | Restart Claude Code (tools load at session start). |
| `not Connected` in `mcp list` | Check `which live-coding-music-mcp`; reinstall if missing. |
| Browser opens but no sound | Click once in the Chromium window (browsers need a user gesture to start audio); make sure a pattern is actually playing. |
| Want to remove it | `claude mcp remove strudel` |

## Reference
- Full config docs: <https://docs.claude.com/en/docs/claude-code/mcp>
