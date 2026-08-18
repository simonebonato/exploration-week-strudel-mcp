# Open failure points — for colleague meeting 2026-08-19

Context: Exploration Week (early September). Decisions from the 2026-08-18 grill:

- **Students go hands-on** — they install the MCP server and drive it from their own
  laptops. The *student* path is the critical path, not the presenter demo.
- **Own laptops, mixed OS** → a full Windows dry-run before September is a must
  (Simone can borrow/own a Windows machine for it).
- **Pre-work email + on-day check** — students install Node/CLI/server before the day;
  workshop starts with a 15-min straggler fix, not a from-zero install.
- **3-client support = coverage, not showmanship** — students come with whatever agent
  setup they already have (Claude Code / Codex / free Google → Antigravity). Each client
  must work so the whole room is covered; no big 3-client stage demo needed.
- **Engagement = missions + finale showcase** (no competition): a ladder of small concrete
  goals ending with each group playing a ~30-sec track to the room. Simone's own test run
  showed open-ended "make music" gets boring in ~10 minutes.
- **Last mission rung is about MCP, not music**: MCP Inspector
  (`npx @modelcontextprotocol/inspector live-coding-music-mcp`), find an unused tool,
  make it do something; close with "what else could an MCP server drive?"

## 1. What "brain" drives the agent on student laptops?

- Primary candidate: **Antigravity CLI free tier** (personal Google account, `agy`).
  - ⚠️ Simone is skeptical: free Flash quota already ran out once during solo testing
    (2026-07-01, see `logs/costs-and-quota.md`). A room of ~20 students hammering it
    will likely hit limits fast.
  - Unknown: how many prompts a student session actually burns (never measured).

## 2. Backup options if/when quota dies mid-workshop (undecided)

| Option | Upside | Downside / open question |
|---|---|---|
| **FHNW provides API credits** (~€50–100 covers a room/day; e.g. `ANTHROPIC_API_KEY` with Claude Code) | Cheap, reliable, removes the gamble | Needs org/budget decision NOW; which CLIs accept raw keys? |
| **Local models** (Ollama + Goose/ollmcp, 14B tool-calling model) | Infinitely free, offline | Untested with this MCP; student laptops may be too weak; flaky multi-step tool calls |
| **Pair students** (2–3 per laptop) | Stretches quota, no new deps | Quota math still a guess until measured |
| **Fall back to presenter demo** | Zero prep | Hands-on students lose their toy mid-session — the exact failure we want to avoid |

## 3. Related open questions for the meeting

- Do students bring their own laptops (Windows/Mac mix?) or use school machines?
- Can FHNW pre-provision anything (accounts, credits, installed software) before the day?
- Venue network: does the school Wi-Fi allow npm registry + Playwright browser download
  + strudel.cc?
- Sound: 20 laptops playing techno at once — headphones rule?
