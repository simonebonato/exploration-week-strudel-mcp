# Strudel MCP in Claude Desktop

**Status: adopted as a supported student client — 2026-08-31.**
The server spawns and completes a full MCP handshake under Claude Desktop's launch
environment on macOS (`initialize` OK, **26 tools** listed). The complete student guide
was then verified end to end in Claude Desktop on macOS, including audible Strudel output,
on 2026-08-31. **Evidence still to collect:** a real Windows smoke test.

This is the technical reference for presenters. Students use
[`../student/claude-desktop.md`](../student/claude-desktop.md).

> [!NOTE]
> **Why this guide exists.** Claude Desktop gives students a familiar chat app during the
> workshop. The current manual setup still uses a terminal once; normal workshop use does
> not. `claude.ai` in a browser **cannot** do it — the web app supports only *remote*
> connectors over HTTPS, and even a hosted version of this server would drive a browser in
> a datacentre, so the music would play in the wrong room. The browser has to be on the
> student's own machine. Claude Desktop is a local app, so it qualifies; the web UI never
> will.

## The one rule: absolute paths. Both operating systems.

This is not the same as Claude Code, where `claude mcp add strudel live-coding-music-mcp`
works. **In Claude Desktop the bare command name fails**, and so does anything else that
relies on your shell's `PATH`.

Claude Desktop is launched by the OS, not by your shell, so it never reads `.zshrc` /
`.bashrc` / nvm. **Measured on this machine, 2026-08-31**, in a shell with Claude Desktop's
minimal environment:

```
live-coding-music-mcp   → NOT FOUND
node                    → NOT FOUND      ← node itself is not on that PATH
uvx                     → NOT FOUND
```

Same probe with absolute paths → `initialize` OK, 26 tools. So:

> [!IMPORTANT]
> Use **absolute path to `node`** as `command`, and **absolute path to `dist/index.js`** as
> the only argument. This is the identical rule already required for
> [Claude Code on Windows](./claude-code.md#-windows-register-with-the-absolute-node-form) —
> here it applies on **macOS too**, and for a different reason (launch environment, not
> `.cmd` shims).

## Setup

### 1. Install the server (skip if already done)

```bash
npm install -g @williamzujkowski/live-coding-music-mcp@4.0.0
```

### 2. Find your two absolute paths

```bash
# macOS / Linux
which node
echo "$(npm root -g)/@williamzujkowski/live-coding-music-mcp/dist/index.js"
```

```powershell
# Windows PowerShell
(Get-Command node).Source
"$(npm root -g)\@williamzujkowski\live-coding-music-mcp\dist\index.js"
```

Copy both. Do not shorten them, do not use `~` or `%APPDATA%` — the config file does no
variable expansion.

### 3. Open the config

Claude menu in the **system menu bar** (not the in-window settings) → **Settings…** →
**Developer** tab → **Edit Config**. That opens:

| OS | File |
| --- | --- |
| macOS | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| Windows | `%APPDATA%\Claude\claude_desktop_config.json` |

### 4. Add the server

Add a `strudel` key inside `mcpServers`. **Keep any servers already there** — if the
Blender station is registered in the same app, both can coexist.

```json
{
  "mcpServers": {
    "strudel": {
      "command": "/absolute/path/to/node",
      "args": ["/absolute/path/to/@williamzujkowski/live-coding-music-mcp/dist/index.js"]
    }
  }
}
```

On Windows, **escape every backslash**:

```json
{
  "mcpServers": {
    "strudel": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": ["C:\\Users\\you\\AppData\\Roaming\\npm\\node_modules\\@williamzujkowski\\live-coding-music-mcp\\dist\\index.js"]
    }
  }
}
```

> [!WARNING]
> A single trailing comma or unescaped backslash makes the whole file invalid, and Claude
> Desktop then silently loads **no** servers — including ones that worked yesterday. If
> everything vanishes at once, suspect JSON syntax first.

### 5. Fully quit and reopen

**Cmd+Q** (macOS) / right-click the tray icon → Quit (Windows). Closing the window is not
enough — the app keeps running and the config is only read at launch.

## Verify it

1. **In the app:** click **"Add files, connectors, and more"** at the bottom-left of the
   message box → **Connectors** → **Manage connectors** → `strudel` should be listed with
   its tools.
2. **In the log**, which is the honest answer when the UI is ambiguous:
   ```bash
   tail -n 40 ~/Library/Logs/Claude/mcp-server-strudel.log       # macOS
   ```
   ```powershell
   type "%APPDATA%\Claude\logs\mcp-server-strudel.log"           # Windows
   ```
   Expect `Enhanced Strudel MCP server ... running`. `ENOENT` means a wrong path — go back
   to step 2.
3. **End to end:** type *"Initialize Strudel and play a four-on-the-floor kick."* A
   Chromium window should open at strudel.cc and make noise. If it's silent, **click once
   inside the Chromium window** — Web Audio needs a user gesture.

## Differences from Claude Code you must know before presenting

| | Claude Code | Claude Desktop |
| --- | --- | --- |
| Register | `claude mcp add strudel live-coding-music-mcp` | hand-edit JSON, absolute paths |
| List / check | `claude mcp list` | Connectors panel, or the log file |
| **Recover a dead session** | `/mcp` → reconnect | **no `/mcp` command — you must fully quit and reopen the app** |
| Reload after config change | new session | full app restart |

> [!CAUTION]
> **🔴 The closed-Chromium-window failure is worse here.** As documented in the project
> [`CLAUDE.md`](../../CLAUDE.md), closing the Chromium window kills the session
> unrecoverably: `init` then answers `"Already initialized"` and `diagnostics` will
> cheerfully report `initialized: true` from cache. In Claude Code the fix is `/mcp` →
> reconnect. **Claude Desktop has no equivalent**, so the recovery is a full app quit and
> relaunch — losing the conversation's place. Teach "don't close that window" harder here,
> and see [`recovery-playbook.md`](./recovery-playbook.md).

> [!WARNING]
> **One client at a time.** Each client spawns its own server and its own Chromium window.
> If Claude Code also has `strudel` registered, quit it before using Claude Desktop, or you
> get two browsers fighting over your speakers.

## Remaining verification and improvement work

- [x] Student installation and audible output confirmed end to end in Claude Desktop on
      macOS (2026-08-31)
- [ ] Windows smoke test, on real hardware, the way [Claude Code was tested](./claude-code.md) on 2026-08-24
- [x] A beginner-facing manual guide avoids asking students to construct paths themselves:
      [`../student/claude-desktop.md`](../student/claude-desktop.md)
- [ ] Package this server as a `.mcpb` Desktop Extension. Anthropic officially supports
      one-click private extensions and bundles a Node runtime, but this server does not
      currently ship one. Until then, Node installation and one terminal step remain.
- [ ] Does the per-tool approval flow get tedious? Claude Desktop has no
      `--dangerously-skip-permissions` equivalent, and this server makes *many* calls
- [x] Project decision 9 updated: Claude Desktop adopted as the primary student client

## Reference

- [Getting started with local MCP servers](https://support.claude.com/en/articles/10949351-getting-started-with-local-mcp-servers-on-claude-desktop) — Anthropic's Desktop Extension and local-server guide
- [Connect to local MCP servers](https://modelcontextprotocol.io/docs/develop/connect-local-servers) — MCP walkthrough
- [Custom connectors / remote MCP](https://support.claude.com/en/articles/11175166-get-started-with-custom-connectors-using-remote-mcp) — the reason the **web** UI cannot do this
