# Prompt library test — 2026-08-21

Rehearsal **test 6** ("every prompt against a live agent") for
[`docs/strudel/prompts.md`](../docs/strudel/prompts.md), run across two sessions on
2026-08-21. This is the raw evidence; the verdict lives in
[`docs/rehearsal.md`](../docs/rehearsal.md#6--every-prompt-against-a-live-agent).

## Conditions

| | |
| --- | --- |
| **Model** | **Claude Sonnet** |
| **Effort** | **low** — below the Claude Code default |
| Client | Claude Code |
| Server | `@williamzujkowski/live-coding-music-mcp` v4.0.0, headed Chromium |
| Machine | the demo machine (macOS) |

> [!IMPORTANT]
> Everything below was produced at **Sonnet / low effort**. That is *below* what a student
> on defaults gets, so every pass here is a conservative pass. This extends the test 2b
> finding from the reggae demo to the whole prompt library.

## Headline

**The library works.** 17 of the 21 prompts were exercised; all but one produced what the
prompt implies, first try, in one turn. **One prompt is dropped** (see MAKE 5). Four were
not run and are still ⬜.

The two prompts the presenter rated highest are both ones a student would never invent
alone: *"three versions, three moods, same tempo and key"* (MAKE) and *"ask me questions
until you work out what's bothering me"* (GIVE ME OPTIONS).

---

## MAKE

Run by the presenter, separately from the transcript below.

| # | Prompt | Verdict |
| --- | --- | --- |
| 1 | Reggae — slow, heavy bass, offbeat guitar | ✅ (already covered by test 2b/4, 2026-08-20) |
| 2 | Trip-hop — dusty drums, slow, melancholy | ✅ **worked very well** |
| 3 | Two artists collided — *Polyphia × Red Hot Chili Peppers* | ✅ **worked surprisingly well.** Simpler than a real song, but the idea comes across, and the agent's account of what each artist contributes is the interesting half |
| 4 | Start with a kick, add one instrument at a time, wait for me | ✅ **awesome.** Added violin, harp and cowbell on request. **The cowbell came out silent; asking the agent to fix it fixed it** — see "moments worth stealing" below |
| 5 | Gradually gets stranger over two minutes | ❌ **DROPPED.** Worked *somewhat*, but you wait a long time for it and the instruments were hard to pick out — needed close attention to hear the strangeness. Fails the "reliably produces something interesting" bar in front of a beginner. Removed from `prompts.md` 2026-08-21; text preserved at the bottom of this file |
| 6 | Three versions, three moods (hopeful / anxious / exhausted), same tempo and key | ⭐ **the best prompt so far.** Three URLs below |

### MAKE 6 — the three moods (tested, replayable)

The A/B/C is the whole point: same tempo, same key, three different emotional reads. This
is a ready-made demonstration for the *"what makes a track sad?"* teaching prompt.

- **hopeful** — <https://strudel.cc/#c3RhY2soCiAgcygiYmQgfiB%2BIGJkIH4gfiBzZCB%2BIikuZ2FpbigwLjg1KSwKICBzKCJoaCo4IikuZ2FpbigwLjMpLAogIG5vdGUoIjxjMyBmMyBnMyBjMz4iKS5zKCJzYXd0b290aCIpLmxwZig3MDApLmdhaW4oMC44KSwKICBub3RlKCI8W2M0LGU0LGc0XSBbZjQsYTQsYzVdIFtnNCxiNCxkNV0gW2M0LGU0LGc0XT4iKQogICAgLnMoImdtX2VwaWFubzEiKS5jbGlwKDEuMikuZ2FpbigwLjUpLnJvb20oMC40KSwKICBub3RlKCI8ZTUgZzUgYzYgZTU%2BIikucygic2luZSIpLmNsaXAoMC44KS5nYWluKDAuMykucm9vbSgwLjUpCikK>
- **anxious** (video-game flavoured) — <https://strudel.cc/#c3RhY2soCiAgcygiYmQgfiBiZCB%2BIHNkIGJkIH4gc2QiKS5nYWluKDAuOSksCiAgcygiaGgqMTYiKS5nYWluKDAuMjUpLnNvbWV0aW1lc0J5KDAuNCwgeCA9PiB4LnNwZWVkKDEuNSkpLAogIG5vdGUoIjxjMyBkYjMgZzMgYzM%2BIikucygic2F3dG9vdGgiKS5scGYoNDAwKS5nYWluKDAuODUpLmRpc3RvcnQoMC4yKSwKICBub3RlKCI8W2M0LGViNCxnYjRdIFtkYjQsZjQsYWI0XSBbZzQsYmI0LGRiNV0gW2M0LGViNCxnYjRdPiIpCiAgICAucygiZ21fZXBpYW5vMSIpLmNsaXAoIjwwLjE1IDAuMjUgMC4xNSAwLjM%2BIikuZ2FpbigwLjUpLmZhc3QoMiksCiAgbm90ZSgifiB%2BIFtjNiBkYjZdIH4gfiBlYjYgfiBbZ2I1IGRiNl0iKS5zKCJzaW5lIikuY2xpcCgwLjE1KS5nYWluKDAuMykKKQ%3D%3D>
- **exhausted** (very slow) — <https://strudel.cc/#c3RhY2soCiAgcygiYmQgfiB%2BIH4gfiB%2BIHNkIH4iKS5nYWluKDAuNiksCiAgcygiaGggfiB%2BIGhoIH4gfiB%2BIH4iKS5nYWluKDAuMiksCiAgbm90ZSgiPGMyIH4gfiBmMj4iKS5zKCJzYXd0b290aCIpLmxwZigyNTApLmdhaW4oMC42KS5yZWxlYXNlKDAuNCksCiAgbm90ZSgiPFtjNCxlNCxnNF0gfiB%2BIFtmNCxhNCxjNV0%2BIikKICAgIC5zKCJnbV9lcGlhbm8xIikuY2xpcCgiPDIgMC4zIDEuNSAwLjQ%2BIikuZ2FpbigwLjM1KS5scGYoNjAwKS5yb29tKDAuNikKKQ%3D%3D>

Note what the agent reached for unprompted to carry the mood: `gm_epiano1` as a shared
voice across all three, `.clip()` patterned per-cycle (`clip("<2 0.3 1.5 0.4>")`) for the
exhausted one, `sometimesBy(0.4, x => x.speed(1.5))` for the anxious jitter. None of that
is in the primer — which is exactly the point of the seed prompts.

---

## TEACH ME — the software

Run in-transcript. The first four ran while the browser session was dead (see finding **A**),
so they were answered as **text only, with no audio** — and still passed, because they are
explanation prompts.

| # | Prompt | Verdict |
| --- | --- | --- |
| 1 | How do I add reverb? | ✅ **worked perfectly.** `room` + `size`, with the *how much* vs *how big* split, and the tip to try it on a sustained sound rather than a short drum hit |
| 2 | Explain `sound("bd(3,8)").room(0.3)` piece by piece | ✅ Broke out the sample name, the Euclidean `(3,8)` → `bd ~ ~ bd ~ ~ bd ~`, and the reverb send |
| 3 | Kick four times per bar, explain the syntax | ✅ `"bd*4"`, and — the useful part — *why* `"bd bd bd bd"` and `"bd*4"` are the same thing, plus the `~` / `[]` / `<>` / `*n` reference |
| 4 | Three ways to make this less repetitive | ✅ Offered `<>` alternation, Euclidean, and probability (`sometimes`/`degradeBy`), explained each **before** changing anything, then applied only the one that was picked |
| 5 | Teach me the commands in the code you just wrote | ✅ Walked `$:` → `s()` → mini-notation → `.bank()` → effect chain, in that order |

### Two unlisted prompts that came up naturally — both worth adding

Neither is in `prompts.md`. Both are things a student will absolutely do.

**"what is the dollar sign for then?"** — ✅ good answer. `$:` marks a line as an
independent top-level pattern; one `$:` per simultaneous layer; contrast with `stack()`,
which merges layers into *one* pattern you can transform together.

**"why this does not work? \<pastes broken code\>"** — ⚠️ **right fix, wrong reason.**
The agent correctly spotted the missing `$:` on line 2 and gave working code. But it
explained the failure as *"that's a syntax error"*, and **that is false.** Verified with
`transpile_pattern`:

```js
// input
$: s("[bd <hh oh>]*2").bank("tr909")
  .dec(.4).room(0.3).size(2)
  sound("bd(3,8)")

// transpiles fine — no error:
s(m('[bd <hh oh>]*2', 5)).bank(m('tr909', 28)).dec(0.4).room(0.3).size(2).p('$');
return sound(m('bd(3,8)', 74));
```

`$:` is a JavaScript **labelled statement**, so the bare line parses perfectly well — it
just becomes the returned expression instead of a registered layer. The student hears the
wrong thing, not an error message.

> [!IMPORTANT]
> **This is the best accidental teaching moment of the whole test.** The agent produced a
> confident, plausible, wrong explanation next to a correct fix, and nothing in the output
> distinguished the two. It extends *"you are the ears"* to *"you are also the fact-check"* —
> and it transfers to Blender unchanged. Consider making it a deliberate beat in the
> "three levels" segment.

---

## TEACH ME — the music

| # | Prompt | Verdict |
| --- | --- | --- |
| 1 | I recognise ⟨genre⟩ but don't know what defines it | ✅ **Run with "metal rock" substituted, not reggae** — so this also tests the *"swap reggae for anything"* claim at the bottom of `prompts.md`. Got tempo, double-kick, palm-muting, downtuned distorted guitar, bass doubling the riff, then built it. The `.clip(0.3)` trick for a palm-muted chug came from the agent |
| 2 | House vs techno, build a short example of each | ✅ Strong. Same kick, and the *difference* carried by swung offbeat open-hats + a moving bassline (house) against relentless `hh*8` + one static note (techno). Both loaded and confirmed playing |
| 3 | What makes a track sound sad? | ✅ Ranked the levers — key/mode > arrangement density > timbre > tempo — and argued tempo is the *weakest* one. Presenter asked for it **one layer at a time** and the agent complied without being told twice |
| 4 | Explain song structure, then arrange this loop | ✅ Reached for **`arrange()`** unprompted and produced a real intro → verse → chorus → breakdown contour with different layer counts per section. Best single demonstration that the agent knows more Strudel than the primer teaches |
| 5 | Why does this sound muddy? | ⬜ **not run** |

Also exercised as a follow-up, not in the library: *"now turn it bright and happy with the
same instruments"* — ✅, and a good A/B, since it flips every lever from prompt 3 while
holding the instrument list fixed.

---

## GIVE ME OPTIONS

| # | Prompt | Verdict |
| --- | --- | --- |
| 1 | Three possible changes at each step, let me choose | ✅ **Two full rounds, waited every time.** Options were genuinely different in kind (drums vs. different drums vs. no drums / work on harmony instead), not three flavours of the same move |
| 2 | Reggae, one instrument at a time, wait for me | ✅ (covered by test 2b, 2026-08-20) |
| 3 | Transform trip-hop → trance step by step | ⬜ **not run** |
| 4 | Make this dark, tell me first, in three stages | ⚠️ **partial — stages 1 and 2 only.** Not a prompt failure: the agent stated the three-stage plan up front, ran stage 1 (minor key alone) and stage 2 (darker filtering + wetter reverb), and the presenter changed direction before stage 3. **Still needs one clean run to the end** |
| 5 | Ask me questions until you work out what's bothering me | ✅ **Excellent.** Narrowed in two rounds — rhythm-not-tone → missing-not-clashing → low-end punch — then proposed fixes tied to that answer. Notable: it fired Claude Code's **interactive multiple-choice picker**, which makes it land visually in a way a wall of text would not |
| 6 | Act as my producer, change nothing until I agree | ✅ **Excellent, and the strongest structural result of the test.** The presenter edited the pattern **by hand in the browser**; the agent read the edits back with `get_pattern`, diffed them against what it had written, and gave four specific notes (dropped intro; clap reverb 0.3 → 1 will smear the transient; **bass reverb 0.2 → 1 will undo the low-end tightening**; hats 0.15 → 0.6 reads as a good call). It changed nothing until told to |

### The producer round trip is the finding

Hand-editing in the browser and agent-editing over MCP **coexist**. `get_pattern` sees
manual edits, so the agent can critique work it did not write. That is a genuinely
different workshop mode from "the agent drives" and it costs nothing to teach.

### Not run

⬜ *"Save this version as reggae-v2"* · ⬜ the single fallback prompt at the bottom of
`prompts.md` (its reggae form is covered by test 2b, but not the prompt verbatim).

### Output of the GIVE ME OPTIONS chain (tested, replayable)

Where the session ended up after ~10 rounds of options, notes and fixes — a sectioned
trip-hop arrangement:

<https://strudel.cc/#YXJyYW5nZSgKICBbOCwgc3RhY2soCiAgICBub3RlKCJjNCBlYjQgZzQgZWI0Iikuc2xvdygyKS5zKCJwaWFubyIpLnJvb20oMC40KS5zaXplKDQpLmdhaW4oMC44KSwKICAgIG5vdGUoIn4gZzQgfiB%2BIGViNCB%2BIGM0IH4iKS5zKCJwaWFubyIpLmNsaXAoMC4zKS5nYWluKDAuNSkucm9vbSgwLjMpLAogICAgbm90ZSgiYzIgfiB%2BIGMyIH4gfiB%2BIH4iKS5zKCJzYXd0b290aCIpLmxwZigyMDApLmdhaW4oMC44KS5yb29tKDAuMikuY2xpcCgwLjQpLmF0dGFjaygwLjAxKSwKICAgIHMoImJkIH4gfiBiZCB%2BIH4gfiB%2BIikuYmFuaygidHI5MDkiKS5kaXN0b3J0KDAuMykuZ2FpbigwLjk1KSwKICAgIHMoIn4gfiB%2BIH4gY3AgfiB%2BIH4iKS5iYW5rKCJ0cjkwOSIpLmdhaW4oMC43KS5yb29tKDEpLAogICAgcygiaGgqOCIpLmJhbmsoInRyOTA5IikuZ2FpbigwLjE1KS5scGYoMjAwMCkKICApXSwKICBbOCwgc3RhY2soCiAgICBub3RlKCJjNCBlYjQgZzQgZWI0Iikuc2xvdygyKS5zKCJwaWFubyIpLnJvb20oMC40KS5zaXplKDQpLmdhaW4oMC44KSwKICAgIG5vdGUoIn4gZzQgfiB%2BIGViNCB%2BIGM0IH4iKS5zKCJwaWFubyIpLmNsaXAoMC4zKS5nYWluKDAuNikucm9vbSgwLjMpLAogICAgbm90ZSgiYzIgfiB%2BIGMyIH4gfiB%2BIH4iKS5zKCJzYXd0b290aCIpLmxwZigyMDApLmdhaW4oMC44KS5yb29tKDAuMikuY2xpcCgwLjQpLmF0dGFjaygwLjAxKSwKICAgIG5vdGUoIltjNCxlYjQsZzRdKjIiKS5zKCJzaW5lIikuYXR0YWNrKDAuMDIpLnJlbGVhc2UoMC4yKS5scGYoOTAwKS5nYWluKDAuNCkucm9vbSgwLjQpLnNpemUoNCksCiAgICBzKCJiZCB%2BIH4gYmQgfiB%2BIH4gfiIpLmJhbmsoInRyOTA5IikuZGlzdG9ydCgwLjMpLmdhaW4oMSksCiAgICBzKCJ%2BIH4gfiB%2BIGNwIH4gfiB%2BIikuYmFuaygidHI5MDkiKS5nYWluKDAuOCkucm9vbSgwLjMpLAogICAgcygiaGgqOCIpLmJhbmsoInRyOTA5IikuZ2FpbigwLjYpLmxwZigyMDAwKQogICldLAogIFs0LCBzdGFjaygKICAgIG5vdGUoIltjNCxlYjQsZzRdKjIiKS5zKCJzaW5lIikuYXR0YWNrKDEuNSkucmVsZWFzZSgyKS5scGYoMzAwKS5nYWluKDAuMykucm9vbSgwLjg1KS5zaXplKDYpCiAgKV0sCikK>

---

## Moments worth stealing for the workshop

1. **The silent cowbell.** In MAKE 4 the agent added a cowbell that made no sound; the
   presenter said so, and the agent fixed it. This is the descriptive-feedback loop working
   in public, on a real failure, in one turn — a better argument for *"you are the ears"*
   than any slide.
2. **The confident wrong explanation** (TEACH ME software, unlisted prompt 2). See the
   callout above.
3. **The producer diff** (GIVE ME OPTIONS 6) — the agent critiquing the *student's* manual
   edits, not its own output.
4. **`analyze` as running commentary.** It was called after every single change across the
   whole session and never once failed or lied about whether sound was happening. The
   "it can measure it" claim held up under ~20 consecutive calls.

---

## Technical findings

### A 🔴 The browser session dies, and nothing in the server recovers it

**Hit twice on 2026-08-21.** Every browser-backed tool starts returning:

```
page.evaluate: Target page, context or browser has been closed
```

**Everything the recovery playbook and the tool surface suggest you try, fails:**

| What you try | What actually happens |
| --- | --- |
| `init` | returns **`"Already initialized"`** — does **not** relaunch the browser |
| `diagnostics({level:"status"})` | reports `initialized: true` — and on the second occurrence `playing: true` — **while the browser is dead**. It reads cached state, so it is worse than useless here |
| `session({action:"create"})` | `page.waitForFunction: Timeout 30000ms exceeded` |
| `session({action:"destroy", session_id:"default"})` | `Session 'default' not found` — the default session isn't in the session registry, so you can't destroy it |
| `browser_window({action:"show"})` | same closed-target error |
| opening a strudel.cc URL by hand | irrelevant — the MCP drives its **own** Playwright context, not your tab |

**The only fix is client-side: reconnect the MCP server** (`/mcp` in Claude Code). After
that, everything worked immediately.

> [!TIP]
> **The tell:** a healthy fresh start returns **`"Strudel initialized successfully"`**.
> If `init` says **`"Already initialized"`** when you expected a fresh launch, the session
> is dead — stop retrying tools and reconnect the client.

**Trigger: closing the Chromium window. Confirmed** — the presenter closed the window by
hand before the second occurrence. The server does not notice, does not relaunch, and
cannot be talked into relaunching.

This matters more than it looks: **closing the browser window is the single most obvious
thing a confused student will do**, and it puts them into a state where the agent keeps
cheerfully reporting `initialized: true` while nothing works. Expect to hit this in the
room. The rule to teach is *don't close the Chromium window — and if you did, reconnect
the MCP server, not the browser.*

(An earlier hypothesis that hand-editing in the browser was the trigger is **not**
supported — the producer-mode round trip in GIVE ME OPTIONS 6 involved plenty of manual
editing with no session death.)

➡️ Row 1 of [`docs/setup/recovery-playbook.md`](../docs/setup/recovery-playbook.md) said
*"ask the agent to initialize again"*. **That is wrong and is now corrected.**

### B 🟡 `analyze`: `tempo` and `rhythm` are broken too — only `spectrum` is usable

On a full six-layer trip-hop arrangement that was **audibly playing** (`isPlaying: true`,
`average 33.7`, `bass 214`):

```json
"rhythm": { "pattern": "X...", "complexity": 0, "density": 0,
            "syncopation": 0, "onsets": [], "isRegular": true },
"tempo":  { "bpm": 0, "confidence": 0,
            "message": "No tempo detected. Ensure audio is playing and has a clear rhythmic pattern." }
```

Both are empty on obviously rhythmic audio. **Use `include: ["spectrum"]` and ignore the
rest.** Added to the caveats in `AGENTS.md`/`CLAUDE.md`.

### C ⚪ `brightness` re-confirmed broken, with a clean counter-example

The deliberately bright/happy build — major key, `lpf(2000–3000)`, short envelopes, minimal
reverb, built explicitly *to be* bright — still reported `"brightness": "dark"`. Known bug
(bin-index centroid vs Hz thresholds); this is just a tidy demonstration of it.

### D 🟡 `validate_pattern_local` rejects **every** `$:` pattern

```
$: s("bd*4")
$: s("hh*8")
→ { valid: false, errors: ["Runtime error: s(...).p is not a function"] }
```

That pattern is fine. The in-process engine has no `.p()`, so the local validator gives a
**false negative on any multi-layer pattern** — which is most of what the agent writes.
It did not block anything in practice (`edit_pattern` writes with `validate: true`
succeeded throughout), but don't trust it as a checker, and don't teach it.

`transpile_pattern` **does** handle `$:` correctly — use that instead. Both work with the
browser dead, which is how finding A's transpile evidence was gathered.

### E ⚪ `edit_pattern` `mode=replace` replaces only the first match, and doesn't play

Fixing the same line in both the verse and chorus of an `arrange()` needed **two** calls,
and then an explicit `playback({action: "play"})` — `mode=replace` has no `auto_play`.
Fine once you know; mildly annoying live. Prefer `mode=write` with the whole pattern.

### F ⚪ Token usage

Contained across a long multi-turn session. **Unknown whether it holds for a full
workshop's worth of hours** — worth watching during the dress rehearsal.

---

## Carry-overs

- [ ] Run the four ⬜ prompts: *why does this sound muddy* · *trip-hop → trance* ·
      *save this version as …* · the single fallback prompt verbatim
- [ ] Re-run *"make this dark in three stages"* **to the end** — stage 3 never happened
- [ ] Add the two unlisted TEACH ME prompts to `prompts.md` (`$:`, and "why doesn't this
      work?" with broken code) — both came up unprompted and both are things students do
- [ ] Decide whether the confident-wrong-explanation finding becomes a scripted beat in the
      "three levels" segment
- [ ] Watch token burn over a full-length session

## Appendix — the dropped prompt

Preserved so the decision is reversible. Removed from `prompts.md` 2026-08-21:

> Build a track that **gradually gets stranger over two minutes**: start completely
> normal, end somewhere I wouldn't have predicted.

Verdict: worked somewhat, but slow to pay off and the changes were hard to hear without
close attention. In a room of beginners with headphones on, that reads as "nothing is
happening."
