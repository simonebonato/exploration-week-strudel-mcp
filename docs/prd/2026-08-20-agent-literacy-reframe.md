# PRD: Exploration Week — Agent Literacy Through Strudel

- **Date:** 2026-08-20
- **Owner:** Simone Bonato
- **Status:** Active. **Supersedes** `2026-07-01-strudel-mcp-teaching-demo.md`.
- **Origin:** colleague feedback (17 items) + grilling session, 2026-08-20.

## 1. What changed, and why

The 2026-07-01 PRD said the subject was **MCP + agents, not music**. Colleague feedback
after the 2026-08-19 meeting was ~80% music and Strudel pedagogy, and surfaced the real
context: this is a **creative-tools Exploration Week** with a sibling Blender station,
not an MCP week.

**New thesis: you cannot direct an AI well in a domain you understand nothing about.**

Students arriving have neither the *instinct* for what agents can do nor the *domain
vocabulary* to ask for it. The workshop supplies both, in the smallest useful dose, and
then gets out of the way. MCP is taught as the **mechanism** — the thing that lets you
point an agent at software you barely know — precisely because that lesson transfers to
Blender the next day.

## 2. Goals

1. Students can **read** Strudel code well enough to direct an agent writing it.
2. Students leave with **three transferable prompting moves** (MAKE / TEACH ME / GIVE ME
   OPTIONS) that work on any software an agent can reach.
3. Students understand **what an agent can and cannot perceive**, and give descriptive
   feedback accordingly.
4. Students understand **what MCP is** well enough to recognise it at the Blender station.
5. Every student makes something they want to keep — and keeps it.

## 3. Non-goals

- A comprehensive Strudel course. One mental model, not a syntax tour.
- A music-production course. Audio recording is an appendix link, not workshop content.
- Supporting every agent CLI. Two, deliberately.
- Free/local-model paths. FHNW funds the plans.
- Feeding audio into the model. Dropped — the supported clients don't accept it.

## 4. Requirements

| # | Requirement | Priority |
|---|---|---|
| R1 | Student front door: **one page, one URL**, no git knowledge assumed | Must |
| R2 | Setup verified end-to-end on **Windows**, both clients | Must |
| R3 | Slidev deck with **live interactive strudel.cc iframes** | Must |
| R4 | Strudel intro built on **one idea**: the cycle | Must |
| R5 | Prompt library, **three modes**, 4–5 ambitious examples each | Must |
| R6 | Core demo rehearsed, with a pre-saved pattern per step as silent insurance | Must |
| R7 | "Three levels of machine perception" segment | Must |
| R8 | Save-your-work rule (copy the URL) taught explicitly | Must |
| R9 | Links: Strudel interactive tutorial + a live-coding video | Should |
| R10 | Pre-work email; on-day 15-min straggler fix | Should |
| R11 | Recovery playbook filled from actual rehearsal failures | Should |

## 5. Session shape

Front-loaded teaching (~35 min), then long open exploration, then a volunteer showcase
with a hard stop. See `AGENTS.md` § Session shape for the slot-by-slot breakdown.

The earlier finding that "open-ended *make music* gets boring in ~10 minutes" is
**retracted**: it went flat because the seeding was thin, not because open-endedness
fails. The fix is ambitious seeds, not a mission ladder.

## 6. Risks

| Risk | Mitigation |
|---|---|
| Windows setup smoke-tested | Full dry-run no longer a hard blocker; basic install + registration + MAKE prompts verified on real hardware |
| Experimental MCP server fails live | Pre-saved pattern per demo step; latency is the teaching slot, so pauses read as intentional |
| Conference wifi | Slidev builds offline; **warm the Strudel sample cache online beforehand** |
| Deck iframe swallows the clicker | Advance iframe slides by mouse-click; rehearse |
| Slidev's AI stack is ~6 weeks old | Pin 52.19.1; rehearse before September |
| `logs/` contains budget + vendor-failure notes and the repo is student-facing | Separate or privatise before publishing |

## 7. Verification

- **Setup:** a clean Windows machine reaches audible sound following only
  `docs/student/START-HERE.md`, on both clients. ✅ Smoke-tested (2026-08-24).
- **Deck:** iframe accepts typing and plays audio, on the presentation machine, in the
  presentation browser, offline.
- **Demo:** full reggae build rehearsed end-to-end; every step's fallback pattern tested.
- **Content:** each prompt in the library run at least once against a real agent.
