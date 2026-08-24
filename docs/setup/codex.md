# Strudel MCP in Codex (OpenAI)

**Status: ✅ registered & `enabled` on codex-cli 0.137.0 (2026-07-01) — live audio pending.**

## Setup in 3 steps

> [!IMPORTANT]
> This guide assumes **Codex is already installed**. If not:
> ```bash
> npm install -g @openai/codex
> ```
> Then check: `codex --version` should print a version number.

```bash
# 1. One-time install (skip if done)
npm install -g @williamzujkowski/live-coding-music-mcp@4.0.0

# 2. Register the server (note the -- separator)
codex mcp add strudel -- live-coding-music-mcp

# 3. Confirm
codex mcp list           # expect: strudel ... enabled
```

> [!TIP]
> **You can skip the browser install.** The server usually downloads Chromium automatically
> the first time it runs. If the agent says the browser is missing, run:
> ```bash
> node "$(npm root -g)/@williamzujkowski/live-coding-music-mcp/node_modules/playwright/cli.js" install chromium --no-shell
> ```

Alternative to step 2 — edit `~/.codex/config.toml` (or a project-scoped
`.codex/config.toml`) directly:

```toml
[mcp_servers.strudel]
command = "live-coding-music-mcp"
# startup_timeout_sec = 20   # bump if the browser is slow to launch
```

> [!NOTE]
> Codex uses `[mcp_servers.<name>]` with an **underscore** — not `mcpServers` like
> JSON-based clients.

> [!WARNING]
> **On this machine** `~/.codex/config.toml` is a symlink into the dotfiles repo
> (`~/dotfiles/ai/codex/config.toml`) — `codex mcp add` writes there. Review before
> committing dotfiles, or use a project-scoped `.codex/config.toml` instead.

## Use it

> [!IMPORTANT]
> Tools load at **session start** → start a **NEW** Codex session after registering.

> [!CAUTION]
> **⚠️ USE AT YOUR OWN RISK — approving every single tool call gets annoying fast.**
> Each pattern edit normally asks for a Y/N confirmation. To let the agent work freely:
>
> ```bash
> codex --yolo    # alias for --dangerously-bypass-approvals-and-sandbox
> ```
>
> The name is honest: this disables **all** approvals and sandboxing — the agent can run
> any command without asking. Fine for a supervised music workshop; do **not** make it
> your default way of running Codex.

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
| Tools don't load | Restart Codex; re-check `~/.codex/config.toml` |
| Windows: server won't start | Launch it through the Windows shell — see [🪟 Windows note](#-windows-if-the-server-wont-start) below |
| Browser opens, **no sound** | Click once inside the Chromium window (audio needs a user gesture) |
| Code changed, **music didn't** | Press **`update`** top right in strudel.cc (or Ctrl/Cmd+Enter) — [screenshot](../assets/strudel-update-button.png) |
| `codex mcp add` unknown | Older Codex builds only read `config.toml` — use the TOML block above |

### 🪟 Windows: register with the absolute-`node` form

On Windows, npm installs the server as `live-coding-music-mcp.cmd` — a `.cmd` shim, not a
real program. Codex has an **open** bug spawning stdio MCP servers via `.cmd`/npx shims
([openai/codex#16229](https://github.com/openai/codex/issues/16229), filed 2026-03-30,
last confirmed 2026-07-02). **`cmd /c` is not a reliable fix** — reports say it converts
"not found" into "timed out".

Use absolute `node` + absolute script path, and **let the CLI write the config**:

```powershell
npm root -g            # prints e.g. C:\Users\you\AppData\Roaming\npm\node_modules

codex mcp add strudel -- node "C:\Users\you\AppData\Roaming\npm\node_modules\@williamzujkowski\live-coding-music-mcp\dist\index.js"
codex mcp list         # expect: strudel ... enabled
```

> [!WARNING]
> **Do not hand-edit `config.toml` on Windows.** TOML basic strings treat `\` as an escape,
> so `"C:\Program Files\nodejs\node.exe"` silently corrupts (`\P` and `\n` are escape
> sequences). If you must, use single-quoted literal strings or doubled backslashes.
>
> Also consider raising the startup budget — Codex's default `startup_timeout_sec` is
> **10 s**:
>
> ```toml
> [mcp_servers.strudel]
> startup_timeout_sec = 60
> ```

> ✅ Smoke-tested on Windows (2026-08-24): Codex registered with the absolute-`node`
> form and ran MAKE prompts successfully.

## Reference

- Codex MCP docs: <https://developers.openai.com/codex/mcp>
- Codex config reference: <https://developers.openai.com/codex/config-reference>
