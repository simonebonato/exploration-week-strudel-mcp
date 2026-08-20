# Core Demo — "Teach me reggae, and build it with me"

The ~12-minute centrepiece. One prompt sequence, run **live**.

> [!IMPORTANT]
> **The agent's thinking time is your teaching slot.** Send the prompt, then talk while it
> works. Every pause below has a script. Done right, the latency reads as deliberate
> pacing rather than dead air — and the room learns the music theory in the gaps.

> [!WARNING]
> **The patterns below are NOT yet play-tested.** They are written from the musical
> characteristics of reggae and standard Strudel syntax, but nobody has heard them.
> **Play-test every one before the session** and correct this file. Until then, treat them
> as sketches, not insurance.

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
- **Fallbacks open in a second window**, ready to paste in 5 seconds. The code blocks in
  this file *are* the fallbacks — keep this page open, or copy them into a scratch text
  file. (Don't rely on `patterns/`: that's the MCP's auto-generated store and it's
  gitignored.)
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

**Fallback pattern** ⚠️ untested:

```js
setcpm(75/4)
stack(
  sound("~ ~ bd ~"),             // kick on 3 only — the one drop
  sound("~ ~ sd ~").gain(0.7),   // side-stick lands with it
  sound("~ hh ~ hh ~ hh ~ hh")   // hats on the offbeats
)
```

---

### Step 3 — The skank (the moment)

**This is the payoff of the whole demo.** The offbeat guitar chord — the *skank*.

**While it thinks:**

> "Here's the thing that makes it reggae. The guitar never plays on the beat. It plays in
> the gaps — on every 'and'. One-AND-two-AND. Listen to where it lands."

**The move:** when it plays, mute the skank and play just the drums. Then bring it back.
Ask the room which one is reggae. They'll get it instantly and they'll have *heard* a
musical concept rather than been told one.

**Fallback pattern** ⚠️ untested — the skank alone:

```js
note("~ [c4,eb4,g4] ~ [c4,eb4,g4] ~ [c4,eb4,g4] ~ [c4,eb4,g4]")
  .sound("triangle").gain(0.45).room(0.2)
```

Eight slots per loop; chords land on slots 2, 4, 6, 8 — the "ands". **Show them this.**
They learned the cycle model 20 minutes ago; this is the moment it pays off, because they
can *read* why it's offbeat.

---

### Step 4 — Bass

**While it thinks:**

> "In most music the bass follows the kick. In reggae the bass is a melody — it's often the
> most memorable line in the track, and it leaves enormous gaps. Space is an instrument
> here."

**Fallback pattern** ⚠️ untested:

```js
note("c2 ~ ~ eb2 ~ g1 ~ ~").sound("sawtooth").lpf(400).gain(0.8)
```

---

### Step 5 — Everything together

**Fallback pattern** ⚠️ untested:

```js
setcpm(75/4)
stack(
  sound("~ ~ bd ~"),
  sound("~ ~ sd ~").gain(0.7),
  sound("~ hh ~ hh ~ hh ~ hh").gain(0.5),
  note("~ [c4,eb4,g4] ~ [c4,eb4,g4] ~ [c4,eb4,g4] ~ [c4,eb4,g4]")
    .sound("triangle").gain(0.45).room(0.2),
  note("c2 ~ ~ eb2 ~ g1 ~ ~").sound("sawtooth").lpf(400).gain(0.8)
)
```

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
| Agent stalls or errors | Paste the fallback pattern, say *"I'll take this one"*, keep talking. Nobody notices |
| Browser dies | *"Initialize Strudel again."* |
| Running long | Skip step 4 (bass). Steps 2, 3 and 6 are the demo; everything else is garnish |

## Pre-flight checklist

- [ ] Every pattern in this file play-tested and corrected
- [ ] Each fallback reachable in 5 seconds (this file open in a second window, or a
      scratch text file on the desktop)
- [ ] Full run-through on the demo machine, timed
- [ ] Sample cache warmed online
- [ ] Step 6 rehearsed — it's the one people rush and it's the most valuable
