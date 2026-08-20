# Core Demo — "Teach me reggae, and build it with me"

The ~12-minute centrepiece. One prompt sequence, run **live**.

> [!IMPORTANT]
> **The agent's thinking time is your teaching slot.** Send the prompt, then talk while it
> works. Every pause below has a script. Done right, the latency reads as deliberate
> pacing rather than dead air — and the room learns the music theory in the gaps.

> [!NOTE]
> **The fallbacks below are real.** They were captured from the passing rehearsal run on
> 2026-08-20 (Claude Sonnet, low effort) — this is the agent's own output, heard on the demo
> machine, not a hand-written sketch. Each step has a **strudel.cc URL**: pasting that into
> the browser is faster and less error-prone than typing code, so that is the fallback move.

---

## Why reggae

It's the best genre for this demo, for one reason: **its defining feature is audible the
instant it's missing.** Take the offbeat guitar out of reggae and the room *hears* the hole.
Take a snare out of techno and nobody can tell you what changed.

That gives you a teaching move nothing else does — build it wrong first, then fix it, and
let them hear the difference.

---

## Setup (before you start talking)

- Agent open, fresh session, MCP connected.
- **Fallbacks open in a second window**, ready in 5 seconds. The four URLs in [the ladder
  below](#the-tested-fallback-ladder) *are* the fallbacks — keep this page open, or drop the
  links in a scratch file / browser bookmarks bar. (Don't rely on `patterns/`: that's the
  MCP's auto-generated store and it's gitignored.)
- Volume tested. Chromium already clicked once (audio needs a user gesture).
- strudel.cc sample cache warmed — **play every sound in this file while you still have
  wifi.**

---

## The sequence

### Step 0 — Open the frame

Say, don't type:

> "I don't know how to make reggae. I know it when I hear it, but I couldn't tell you what
> makes it reggae. So I'm not going to ask for a reggae track — I'm going to ask to be
> taught one."

### Step 1 — The prompt

Type this in full, out loud as you type it:

> I want to understand reggae. Teach me its important musical characteristics, and help me
> build a reggae track in Strudel. Build it **one instrument at a time**. Before you add
> each instrument, explain what role it plays in reggae and what makes it characteristic.
> Give me the code for each step and **wait for me** before continuing.

**Point at the last sentence.** "That's the whole trick. Without *wait for me*, it hands
you a finished track and you've learned nothing."

**While it thinks:** name the three modes — MAKE, TEACH ME, GIVE ME OPTIONS — and say this
prompt is deliberately all three at once.

---

### Step 2 — Drums (the one drop)

**What you're waiting for:** the agent should explain the *one drop* — reggae's kick lands
on beat **3**, not beat 1. Beat 1 is a hole.

**While it thinks, say this:**

> "Almost every genre you know puts the kick on beat 1. It's the anchor. Reggae takes it
> away — the kick lands on **three**. That missing downbeat is why reggae feels like it's
> leaning back instead of pushing forward."

Then count it out loud over the drums when they start: *one — two — BOOM — four.*

**Fallback — [layer 1 ↗](https://strudel.cc/#c3RhY2soCiAgcygifiB%2BIFtiZCBzZF0gfiIpLAogIHMoImhoKjgiKS5nYWluKDAuNSkKKQ%3D%3D)** ✅ heard 2026-08-20:

```js
stack(
  s("~ ~ [bd sd] ~"),      // one drop: kick AND snare together, on beat 3
  s("hh*8").gain(0.5)      // straight eighths keep the pulse while beat 1 is empty
)
```

The `[bd sd]` bracket is worth pointing at — they learned brackets in the primer, and here
the whole genre hangs off the fact that slot 3 is full and slot 1 is empty.

---

### Step 3 — The skank (the moment)

**This is the payoff of the whole demo.** The offbeat guitar chord — the *skank*.

**While it thinks:**

> "Here's the thing that makes it reggae. The guitar never plays on the beat. It plays in
> the gaps — on every 'and'. One-AND-two-AND. Listen to where it lands."

**The move:** when it plays, mute the skank and play just the drums. Then bring it back.
Ask the room which one is reggae. They'll get it instantly and they'll have *heard* a
musical concept rather than been told one.

**Fallback — [layer 3 ↗](https://strudel.cc/#c3RhY2soCiAgcygifiB%2BIFtiZCBzZF0gfiIpLAogIHMoImhoKjgiKS5nYWluKDAuNSksCiAgbm90ZSgiYTEgfiBlMiBnMSIpLnMoInNhd3Rvb3RoIikubHBmKDQwMCkuZ2FpbigwLjkpLAogIG5vdGUoIjxbYTMsZTQsYzRdPiIpLnMoInNxdWFyZSIpCiAgICAuc3RydWN0KCJ%2BIHggfiB4IH4geCB%2BIHgiKQogICAgLmNsaXAoMC4xNSkKICAgIC5nYWluKDAuNykKKQ%3D%3D)** ✅ heard 2026-08-20 — the skank line is:

```js
  note("<[a3,e4,c4]>").s("square")
    .struct("~ x ~ x ~ x ~ x")   // eight slots; chords land on 2,4,6,8 — the "ands"
    .clip(0.15)                  // very short = the chop
    .gain(0.7)
```

**Show them `struct`.** Eight slots, every `x` on an "and", every `~` on a beat. They
learned the cycle model 20 minutes ago; this is the moment it pays off, because they can
*read* why it's offbeat. `.clip(0.15)` is the second half of the sound — the skank is
chopped, not held.

**The mute move:** open the layer-3 link and comment out that block (`Ctrl+/`), hit update,
then uncomment it. Same code, one line, and the room hears reggae appear and disappear.

---

### Step 4 — Bass

**While it thinks:**

> "In most music the bass follows the kick. In reggae the bass is a melody — it's often the
> most memorable line in the track, and it leaves enormous gaps. Space is an instrument
> here."

**Fallback — [layer 2 ↗](https://strudel.cc/#c3RhY2soCiAgcygifiB%2BIFtiZCBzZF0gfiIpLAogIHMoImhoKjgiKS5nYWluKDAuNSksCiAgbm90ZSgiYTEgfiBlMiBnMSIpLnMoInNhd3Rvb3RoIikubHBmKDQwMCkuZ2FpbigwLjkpCik%3D)** ✅ heard 2026-08-20 — the bass line is:

```js
  note("a1 ~ e2 g1").s("sawtooth").lpf(400).gain(0.9)
```

Four slots, one of them empty, and the loudest thing in the mix (`gain 0.9`) with the top
filtered off (`lpf 400`). That's the reggae bass in one line: low, loud, and full of holes.

---

### Step 5 — Everything together

**Fallback — [layer 4 ↗](https://strudel.cc/#c3RhY2soCiAgcygifiB%2BIFtiZCBzZF0gfiIpLAogIHMoImhoKjgiKS5nYWluKDAuNSksCiAgbm90ZSgiYTEgfiBlMiBnMSIpLnMoInNhd3Rvb3RoIikubHBmKDQwMCkuZ2FpbigwLjkpLAogIG5vdGUoIjxbYTMsZTQsYzRdPiIpLnMoInNxdWFyZSIpCiAgICAuc3RydWN0KCJ%2BIHggfiB4IH4geCB%2BIHgiKQogICAgLmNsaXAoMC4xNSkKICAgIC5nYWluKDAuNyksCiAgbm90ZSgiPFthNCxjNSxlNF0%2BIikucygic2luZSIpCiAgICAuc3RydWN0KCJ4IH4geCB4IH4geCB4IH4iKQogICAgLmNsaXAoMC4yKQogICAgLmdhaW4oMC40KQopCg%3D%3D)** ✅ heard 2026-08-20:

```js
stack(
  s("~ ~ [bd sd] ~"),
  s("hh*8").gain(0.5),
  note("a1 ~ e2 g1").s("sawtooth").lpf(400).gain(0.9),
  note("<[a3,e4,c4]>").s("square")
    .struct("~ x ~ x ~ x ~ x")
    .clip(0.15)
    .gain(0.7),
  note("<[a4,c5,e4]>").s("sine")     // top line, added unprompted on the rehearsal run
    .struct("x ~ x x ~ x x ~")
    .clip(0.2)
    .gain(0.4)
)
```

This is also the pattern to hand step 6 — it has an obviously busy hat part and a very loud
bass, which is exactly what the "the hats are too busy and the bass is drowning the guitar"
prompt is about.

---

## The tested fallback ladder

Captured from the passing rehearsal run, **2026-08-20 · Claude Sonnet, low effort**. Each
link is the previous one plus one instrument, so they map onto the steps above. **Paste the
URL, don't type the code** — it's 5 seconds and can't be mistyped.

| # | Adds | Use at | Link |
| --- | --- | --- | --- |
| 1 | one-drop drums + hats | step 2 | [layer 1 ↗](https://strudel.cc/#c3RhY2soCiAgcygifiB%2BIFtiZCBzZF0gfiIpLAogIHMoImhoKjgiKS5nYWluKDAuNSkKKQ%3D%3D) |
| 2 | + bass | step 4 | [layer 2 ↗](https://strudel.cc/#c3RhY2soCiAgcygifiB%2BIFtiZCBzZF0gfiIpLAogIHMoImhoKjgiKS5nYWluKDAuNSksCiAgbm90ZSgiYTEgfiBlMiBnMSIpLnMoInNhd3Rvb3RoIikubHBmKDQwMCkuZ2FpbigwLjkpCik%3D) |
| 3 | + skank | step 3 | [layer 3 ↗](https://strudel.cc/#c3RhY2soCiAgcygifiB%2BIFtiZCBzZF0gfiIpLAogIHMoImhoKjgiKS5nYWluKDAuNSksCiAgbm90ZSgiYTEgfiBlMiBnMSIpLnMoInNhd3Rvb3RoIikubHBmKDQwMCkuZ2FpbigwLjkpLAogIG5vdGUoIjxbYTMsZTQsYzRdPiIpLnMoInNxdWFyZSIpCiAgICAuc3RydWN0KCJ%2BIHggfiB4IH4geCB%2BIHgiKQogICAgLmNsaXAoMC4xNSkKICAgIC5nYWluKDAuNykKKQ%3D%3D) |
| 4 | + top line | step 5 | [layer 4 ↗](https://strudel.cc/#c3RhY2soCiAgcygifiB%2BIFtiZCBzZF0gfiIpLAogIHMoImhoKjgiKS5nYWluKDAuNSksCiAgbm90ZSgiYTEgfiBlMiBnMSIpLnMoInNhd3Rvb3RoIikubHBmKDQwMCkuZ2FpbigwLjkpLAogIG5vdGUoIjxbYTMsZTQsYzRdPiIpLnMoInNxdWFyZSIpCiAgICAuc3RydWN0KCJ%2BIHggfiB4IH4geCB%2BIHgiKQogICAgLmNsaXAoMC4xNSkKICAgIC5nYWluKDAuNyksCiAgbm90ZSgiPFthNCxjNSxlNF0%2BIikucygic2luZSIpCiAgICAuc3RydWN0KCJ4IH4geCB4IH4geCB4IH4iKQogICAgLmNsaXAoMC4yKQogICAgLmdhaW4oMC40KQopCg%3D%3D) |

**Two things to know before you lean on these:**

1. **The agent built bass *before* skank** — steps 3 and 4 above are in the opposite order.
   Nothing in the prompt fixes the order, so expect it to vary run to run. If the live agent
   goes drums → bass → skank, follow it; the ladder already matches that. Just don't jump to
   layer 3 while the room is still waiting to hear the skank *arrive*.
2. **No `setcpm`** — these run at the strudel.cc default, which is faster than the ~75 BPM
   reggae usually sits at. It still reads as reggae (it did in the run), but if you want it
   more authentic, `setcpm(75/4)` on the first line is the one-token fix. **Untested at that
   tempo** — try it before the day, not during.

---

### Step 6 — Show them the limit (don't skip this)

Deliberately type the bad prompt:

> That sounds bad. Fix it.

Let the room watch it flounder. Then:

> "It has no idea what I heard. It can read the code, it can even measure the sound — but
> it cannot judge it. **I'm the ears.**"

Now type the good version:

> The hats are too busy and the bass is drowning the guitar. Thin the hats out and pull the
> bass down.

Two prompts, same intent, completely different results. **This is the most useful 90
seconds of the session** — and it's the bit that transfers straight to Blender.

---

### Step 7 — Hand over

> "Now do that with a genre *you* care about."

Point at [prompts.md](./prompts.md). Say the showcase is in the last 15 minutes and it's
voluntary. Get out of the way.

---

## If it goes wrong

| Failure | Move |
| --- | --- |
| Agent writes code but no sound | Click inside the Chromium window; press **update** in strudel.cc |
| Agent produces something that isn't reggae | **Use it.** *"That's not reggae — what's missing?"* It'll diagnose its own output and you get a better teaching moment than the happy path |
| Agent stalls or errors | Open the matching URL from [the ladder](#the-tested-fallback-ladder), say *"I'll take this one"*, keep talking. Nobody notices |
| Browser dies | *"Initialize Strudel again."* |
| Running long | Skip step 4 (bass). Steps 2, 3 and 6 are the demo; everything else is garnish |

## Pre-flight checklist

- [x] Every pattern in this file play-tested — ✅ 2026-08-20, captured from a live run
- [ ] **Each of the four URLs opened cold once** (they were copied from a working session;
      confirm they still load and play from a fresh window) — 5 min
- [ ] Each fallback reachable in 5 seconds (this file open in a second window, or the four
      links in the bookmarks bar)
- [ ] Full run-through on the demo machine, timed
- [ ] Sample cache warmed online
- [ ] Step 6 rehearsed — it's the one people rush and it's the most valuable
