# Free & Local Ways to Drive the Strudel MCP (so students don't have to pay)

> [!CAUTION]
> **ARCHIVED 2026-08-20 — not a supported path.** FHNW funds the plans, so the free/local
> route is no longer needed. Kept as reference in case funding falls through.
> The local-model paths were never tested.
> See [`README.md`](./README.md).

> Researched 2026-07-01. The hosted free tier is proven; the **local options are not yet
> tested with THIS MCP** — see "Verification status" on each. Test before relying on any of
> them for a live demo.

## The key idea

The MCP server (`live-coding-music-mcp`) is just a **stdio program**. It doesn't care what
model or client talks to it. So the expensive part — the frontier model — is swappable. Any
**MCP-capable client** can drive it, including ones running **free local models**.

```
[ any MCP client ] ──stdio──▶ live-coding-music-mcp ──▶ Chromium ──▶ 🔊
       ▲
   swap this "brain": paid cloud model  OR  free hosted tier  OR  free LOCAL model
```

## ⚠️ The one honest caveat: tool-calling reliability

Driving this MCP means **multi-step tool calls** ("init", then "edit_pattern", then
"playback"...). Frontier hosted models (Claude, GPT, Gemini) are very good at this. **Small
local models (7–8B) are noticeably weaker and flakier** at chaining tool calls. Local is
genuinely free and offline, but:
- Use a model explicitly good at **function/tool calling** (Qwen, Llama, Mistral variants).
- Expect to babysit it more; it may fumble multi-step sequences.
- A bigger local model (14B–32B) + a decent machine helps a lot.

For a *live* demo, prefer a hosted model; offer local as the students' free take-home path.

---

## Three free ways

### Way 1 — Free hosted tier (least setup) ✅ path proven
Use a CLI's free tier. E.g. **Antigravity CLI (`agy`)** on a free Google account (Gemini
Flash). Zero extra install beyond the CLI; the model is good at tool calls.
- **Cost:** €0, but **metered** — daily quota that can run out (we hit this 2026-07-01).
- **Best for:** students who just want to try it briefly; quota resets daily.
- **Setup:** [antigravity-cli.md](./antigravity-cli.md).

### Way 2 — Local model + agent CLI (closest to the demo experience) ⏳ not yet tested
Run a model locally with **[Ollama](https://ollama.com)** (free), driven by an open-source
agent CLI that speaks MCP:
- **[Goose](https://goose-docs.ai)** (Block, Apache-2.0) — open-source agent CLI, works with
  any LLM incl. local Ollama/LM Studio, full MCP support. Most similar to the Claude
  Code / `agy` experience.
- **[ollmcp](https://github.com/jonigl/mcp-client-for-ollama)** — a TUI MCP client purpose-
  built for Ollama; agent mode, multi-server, model switching.
- **Cost:** €0, fully offline after model download.
- **Setup sketch:** install Ollama → `ollama pull qwen2.5` (or another tool-calling model) →
  install Goose/ollmcp → register `live-coding-music-mcp` as an MCP server there.

### Way 3 — Local model + editor client (familiar to VS Code users) ⏳ not yet tested
Run the model with **[LM Studio](https://lmstudio.ai)** or Ollama (both free) and drive the
MCP from a **free VS Code extension**:
- **[Cline](https://github.com/cline/cline)** (MIT) — strong MCP client, human-in-the-loop
  approvals, works with local models.
- **[Continue](https://continue.dev)** — open-source assistant that speaks MCP.
- **[5ire](https://5ire.app)** — cross-platform desktop MCP client + local models.
- **Cost:** €0. **Best for:** students already living in VS Code.

---

## Recommendation for the student session

- **Presenter, live:** keep using **Claude Code** (already paid, most reliable) — or
  Antigravity free tier if quota is fresh. This is the rock-solid path for stage.
- **Students, free take-home:** point them at **Way 2 (Ollama + Goose)** as the primary
  free path, with **Way 3 (LM Studio + Cline)** for the VS Code crowd. Both let them run the
  *exact same MCP server* with zero cost.
- **Action before recommending:** actually test one local path end-to-end with this MCP
  (does a 7–14B local model reliably `init` + play a pattern?). Tracked in `logs/todo.md`.

## Sources
- MCP client directories: <https://github.com/punkpeye/awesome-mcp-clients> · <https://www.pulsemcp.com/clients>
- Ollama + MCP: <https://github.com/jonigl/mcp-client-for-ollama> · <https://github.com/godstale/ollama-mcp-agent>
- Goose providers (local models): <https://goose-docs.ai/docs/getting-started/providers/>
- Local LLM + MCP overview: <https://chatforest.com/guides/mcp-with-local-llms/>
