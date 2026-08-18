# Strudel MCP in Codex (OpenAI)

**Status: ✅ registered & `enabled` on codex-cli 0.137.0 (2026-07-01) — live audio pending.**

## Setup in 3 steps

```bash
# 1. One-time install (skip if done)
npm install -g @williamzujkowski/live-coding-music-mcp@4.0.0
npx playwright install chromium

# 2. Register the server (note the -- separator)
codex mcp add strudel -- live-coding-music-mcp

# 3. Confirm
codex mcp list           # expect: strudel ... enabled
```

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
| Windows: server won't start | Use `command = "cmd"`, `args = ["/c", "live-coding-music-mcp"]` ([why](./service-setup-summary.md)) |
| Browser opens, **no sound** | Click once inside the Chromium window (audio needs a user gesture) |
| `codex mcp add` unknown | Older Codex builds only read `config.toml` — use the TOML block above |

## Reference

- Codex MCP docs: <https://developers.openai.com/codex/mcp>
- Codex config reference: <https://developers.openai.com/codex/config-reference>
