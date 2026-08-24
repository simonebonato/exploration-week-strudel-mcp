# Service Setup Summary (macOS + Windows)

Every service, both platforms, one page.

> [!NOTE]
> macOS steps are **verified** (2026-07-01). **Windows steps are smoke-tested**
> (2026-08-24): Node, the MCP server, and both Claude Code and Codex were confirmed to
> connect and run MAKE prompts on real Windows hardware. Legend below.
>
> Legend: ✅ verified on this machine · 🪟 Windows smoke-tested

## 0. Prerequisites (all clients, both platforms)

| | macOS ✅ | Windows 🪟 |
| --- | --- | --- |
| **Node.js 22+** | `brew install node@22` or nvm | [nodejs.org](https://nodejs.org) installer, `winget install OpenJS.NodeJS.LTS`, or nvm-windows |
| Check | `node -v` (need v22+) | `node -v` in PowerShell |
| **Claude Code or Codex CLI** | `npm install -g @anthropics/claude-code`<br/>or `npm install -g @openai/codex` | `npm install -g @anthropics/claude-code`<br/>or `npm install -g @openai/codex` |
| Check | `claude --version` or `codex --version` | `claude --version` or `codex --version` in PowerShell |
| **Audio** | speakers/headphones | speakers/headphones |

## 1. One-time install (same commands on both platforms)

```bash
npm install -g @williamzujkowski/live-coding-music-mcp@4.0.0
```

> [!TIP]
> **The browser install is optional.** The MCP server usually downloads Chromium
> automatically the first time it runs. Only run the line below if the agent complains that
> the browser is missing.
>
> ```bash
> # macOS/Linux — use the server's OWN playwright CLI so the browser revision always matches,
> # and skip the headless shell (−95 MB macOS / −115 MB Windows; safe because we run headed)
> node "$(npm root -g)/@williamzujkowski/live-coding-music-mcp/node_modules/playwright/cli.js" install chromium --no-shell
>
> # Windows PowerShell — same thing
> node "$(npm root -g)\@williamzujkowski\live-coding-music-mcp\node_modules\playwright\cli.js" install chromium --no-shell
> ```
>
> Do **not** use `npx playwright install chromium`. The server depends on
> `playwright@^1.52.0` — a floating range — so `npx` can resolve a different version and
> download the wrong browser revision, after which the server fails with a missing-browser
> error. It also duplicates ~45 MB into `~/.npm/_npx`. (Measured 2026-08-20.)

The global bin `live-coding-music-mcp` must be on PATH:

| | Location |
| --- | --- |
| macOS (nvm) ✅ | `~/.nvm/versions/node/<ver>/bin/` |
| Windows 🪟 | `%APPDATA%\npm\live-coding-music-mcp.cmd` (npm adds this to PATH) |

> [!NOTE]
> The Playwright *"install your dependencies first"* warning is harmless — Chromium still
> downloads. On Windows, if Chromium fails to launch, install the VC++ redistributable and
> retry. 🪟

> [!IMPORTANT]
> **Windows registration — use the absolute-`node` form.** 🪟
>
> On Windows, npm installs the server as `live-coding-music-mcp.cmd` — a `.cmd` shim, not a
> real program. Both clients have **open upstream bugs** spawning these:
>
> - Codex: [openai/codex#16229](https://github.com/openai/codex/issues/16229) — stdio MCP
>   fails via `.cmd`/npx shims. Open since 2026-03-30, last confirmed 2026-07-02.
> - Claude Code: [#82791](https://github.com/anthropics/claude-code/issues/82791) — stdio
>   MCP times out at 30 s on Windows. Open, updated 2026-08-19.
>
> **`cmd /c` is not a reliable fix** — reports say it converts "not found" into "timed
> out". The configuration confirmed working in both issue threads is **absolute `node` +
> absolute script path**:
>
> ```powershell
> npm root -g    # e.g. C:\Users\you\AppData\Roaming\npm\node_modules
>
> claude mcp add strudel -- node "C:\...\node_modules\@williamzujkowski\live-coding-music-mcp\dist\index.js"
> codex  mcp add strudel -- node "C:\...\node_modules\@williamzujkowski\live-coding-music-mcp\dist\index.js"
> ```
>
> **Let the CLI write the config.** Hand-editing `~/.codex/config.toml` on Windows is a
> classic failure — TOML basic strings treat `\` as an escape, so
> `"C:\Program Files\nodejs\node.exe"` silently corrupts (`\P`, `\n`). If you must edit
> by hand, use single-quoted literal strings or doubled backslashes, and add
> `startup_timeout_sec = 60`.
>
> ✅ Smoke-tested on real Windows hardware (2026-08-24): both Claude Code and Codex
> registered and ran prompts with the absolute-`node` form.

> [!NOTE]
> **Why not `npx` as the registered command?** Measured 2026-08-20: cold `npx` start took
> **12.2 s** to first tool response, against Codex's **10 s** default
> `startup_timeout_sec`. Warm it's ~1.1 s and works offline (pinning `@4.0.0` means no
> per-spawn registry hit) — but the first launch, on a student laptop, on school wifi, is
> exactly when it will fail. It also saves no download. **Keep the global install.**

## 2. Per-service registration

### Claude Code — ✅ verified (audio proven)

Same on both platforms:

```bash
claude mcp add strudel live-coding-music-mcp
claude mcp list            # expect: strudel ... ✔ Connected
```

Tools load at session start → open a **new** session. Full guide:
[claude-code.md](./claude-code.md).

### Codex (OpenAI) — ✅ verified on macOS

```bash
codex mcp add strudel -- live-coding-music-mcp
codex mcp list             # expect: strudel ... enabled
```

| Config file | Path |
| --- | --- |
| macOS/Linux ✅ | `~/.codex/config.toml` |
| Windows 🪟 | `%USERPROFILE%\.codex\config.toml` |

```toml
[mcp_servers.strudel]
command = "live-coding-music-mcp"
```

Full guide: [codex.md](./codex.md).

### Claude Desktop (optional alternative to Claude Code)

Edit the config, then restart the app:

| | Path |
| --- | --- |
| macOS | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| Windows 🪟 | `%APPDATA%\Claude\claude_desktop_config.json` |

```json
{ "mcpServers": { "strudel": { "command": "live-coding-music-mcp" } } }
```

## 3. Pre-demo sanity checklist (per machine)

1. `node -v` → v22+ ✔
2. `live-coding-music-mcp` resolves on PATH ✔
3. Client shows the server connected/enabled ✔
4. Fresh session: *"Initialize Strudel and play a kick"* → **Chromium opens + sound** ✔
5. Browser window died mid-demo? → **reconnect the MCP server in your client** (`/mcp` in
   Claude Code). Do *not* rely on asking the agent to initialize again — verified twice on
   2026-08-21 that `init` returns `"Already initialized"` and relaunches nothing.
   More: [recovery-playbook.md](./recovery-playbook.md).

## 4. Windows verification TODO (before the event)

- [ ] Node 22+ installs; `live-coding-music-mcp` lands on PATH.
- [ ] The bundled-playwright `install chromium --no-shell` succeeds; Chromium launches visibly.
- [ ] Claude Code **and** Codex each connect using the **absolute-`node`** form.
- [ ] Audio is actually **audible** from the Chromium window (not just `isSilent: false`).
