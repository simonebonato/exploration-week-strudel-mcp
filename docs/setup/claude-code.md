# Strudel MCP in Claude Code

**Status: ✅ verified — full student path (install → register → play) re-tested 2026-08-18.**

> [!TIP]
> **Model choice matters for music quality.** Tested 2026-08-18: Sonnet at the *lowest*
> effort setting is fast but sometimes writes incorrect Strudel code; higher effort is
> slower but noticeably more accurate. For the workshop, prefer the default effort (check
> with `/model`) — speed is not the bottleneck, wrong-sounding patterns are.

## Setup in 3 steps

> [!IMPORTANT]
> This guide assumes **Claude Code is already installed**. If not:
> ```bash
> npm install -g @anthropics/claude-code
> ```
> Then check: `claude --version` should print a version number.

```bash
# 1. One-time install (skip if done)
npm install -g @williamzujkowski/live-coding-music-mcp@4.0.0

# 2. Register the server
claude mcp add strudel live-coding-music-mcp

# 3. Confirm
claude mcp list          # expect: strudel ... ✔ Connected
```

> [!TIP]
> **You can skip the browser install.** The server usually downloads Chromium automatically
> the first time it runs. If the agent says the browser is missing, run:
> ```bash
> node "$(npm root -g)/@williamzujkowski/live-coding-music-mcp/node_modules/playwright/cli.js" install chromium --no-shell
> ```

> [!NOTE]
> **Scope:** the default registration is **local** (this project folder only, written to
> `~/.claude.json`). For a demo you run from anywhere, use:
> `claude mcp add --scope user strudel live-coding-music-mcp`

## Use it

> [!IMPORTANT]
> Tools load at **session start** → open a **NEW** Claude Code session after registering.

> [!CAUTION]
> **⚠️ USE AT YOUR OWN RISK — approving every single tool call gets annoying fast.**
> To let the agent work freely without Y/N prompts:
>
> ```bash
> claude --dangerously-skip-permissions
> ```
>
> This disables **all** permission prompts — the agent can run any command without asking.
> Fine for a supervised music workshop; do **not** make it your default.
> *Milder option:* on the first strudel tool prompt, choose **"Always allow"** — approvals
> stop for that tool but everything else stays guarded.

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
| Windows: server won't start | Launch it through the Windows shell — see [🪟 Windows note](#-windows-if-the-server-wont-start) below |
| Browser opens, **no sound** | Click once inside the Chromium window (audio needs a user gesture) |
| Code changed, **music didn't** | Press **`update`** top right in strudel.cc (or Ctrl/Cmd+Enter) — [screenshot](../assets/strudel-update-button.png) |
| Remove it | `claude mcp remove strudel` |

### 🪟 Windows: register with the absolute-`node` form

On Windows, npm installs the server as `live-coding-music-mcp.cmd` — a `.cmd` shim, not a
real program — and Claude Code has an open bug spawning stdio MCP servers this way
([#82791](https://github.com/anthropics/claude-code/issues/82791), updated 2026-08-19:
times out at 30 s).

**`cmd /c` is not a reliable fix** — it tends to turn "not found" into "timed out". Use
absolute `node` + absolute script path, which is the form confirmed working in the issue
threads:

```powershell
npm root -g            # prints e.g. C:\Users\you\AppData\Roaming\npm\node_modules

claude mcp remove strudel
claude mcp add strudel -- node "C:\Users\you\AppData\Roaming\npm\node_modules\@williamzujkowski\live-coding-music-mcp\dist\index.js"
claude mcp list        # expect: strudel ... ✔ Connected
```

> ✅ Smoke-tested on Windows (2026-08-24): Claude Code registered with the absolute-`node`
> form and ran MAKE prompts successfully.

## Reference

- Claude Code MCP docs: <https://docs.claude.com/en/docs/claude-code/mcp>
