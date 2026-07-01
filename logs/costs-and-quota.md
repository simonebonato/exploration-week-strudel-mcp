# Costs & Quota Log

Running notes on what each way of driving the Strudel MCP costs, and quota events.

## Quota events

- **2026-07-01 — Google/Gemini free quota exhausted.** The presenter's free (no-subscription)
  Google account ran out of **Gemini Flash** quota while testing Antigravity CLI (`agy`).
  Free tier is Flash-only since 2026-03-25 and is limited/metered. Free quota generally
  **resets daily**, so it should return — but we cannot rely on it for an uninterrupted live
  demo without either waiting for reset or upgrading.

## Google pricing (verified 2026-07-01, see chat)

- Subscriptions (the lever for CLI/Antigravity quota): Free €0 · AI Plus €4.99 · **AI Pro
  €21.99/mo (~$20) → higher Antigravity agent limits** · AI Ultra €99.99 / €219.99.
- API pay-as-you-go per 1M tokens: 3.5 Flash $1.50/$9 · 3.1 Pro $2/$12 · 2.5 Flash
  $0.30/$2.50 · 2.5 Flash-Lite $0.10/$0.40. Batch = 50% off.
- ⚠️ Unclear whether Antigravity CLI (`agy`) accepts a pay-as-you-go API key to bypass the
  account quota; its auth is Google-account based. TO VERIFY if that route matters.

## Goal: 3 ways for students to use the MCP without paying

The MCP server is model-agnostic (stdio) — any MCP-capable client can drive it. See
`docs/setup/free-and-local-options.md` for the researched options (hosted free tiers +
local models via Ollama/LM Studio).
