---
theme: default
title: Making Music by Asking For It
info: |
  Exploration Week — teaching agent literacy through Strudel.
  Thesis: you cannot direct an AI well in a domain you understand nothing about.
class: text-center
transition: slide-left
mdc: true
drawings:
  persist: false
---

# Making Music<br>by Asking For It

**Exploration Week** · Strudel + AI agents

<div class="pt-12 opacity-60 text-sm">
You will type in plain English. A browser will make music.
</div>

---
layout: statement
---

# You can't direct an AI well<br>in something you understand *nothing* about

<div class="pt-8 text-lg opacity-70">

So today is **not** "here's a magic button."

It's: learn *just enough* about the thing you're making,<br>
so you can actually tell the agent what you want.

</div>

<!--
This is the whole session in one line. Say it, let it sit, move on.
The Blender people are learning the same lesson with a different toy.
-->

---

# Today

<div class="grid grid-cols-2 gap-8 pt-4">
<div>

**~20 min** — What Strudel is. One idea.

**~10 min** — How the agent reaches it. What it can't do.

**~15 min** — I build a reggae track by asking to be taught one.

**The rest** — You make something.

**Last 15 min** — Anyone who wants to, plays it out loud.

</div>
<div class="opacity-70 text-sm pt-2">

Rules:

- 🎧 Headphones on, except at the end
- 💾 When you like it, **copy the URL**
- 🙋 I'm circulating — grab me

</div>
</div>

---
layout: section
---

# 1 · Strudel

Live-coding music in a browser

---
layout: iframe-right
url: https://strudel.cc/
---

# Type. Press play.

<div class="pt-4">

**Ctrl/Cmd + Enter** → play

**Ctrl/Cmd + .** → stop

</div>

<div class="pt-8 text-sm opacity-70">

That's the entire interface.

</div>

<!--
⚠️ NAVIGATION: your clicker will NOT work while focus is in the Strudel iframe.
Click THIS column (the text side) to get arrow keys back, or click the on-screen arrows.

Do this: type sound("bd*4") into the REPL on the right, Ctrl+Enter.
Make a noise BEFORE explaining anything. Then Ctrl+. to stop.
-->

---
layout: statement
---

# Anything in quotes is a pattern<br>that fills **one loop**

<div class="pt-6 text-lg opacity-70">
Whatever you put in it splits that loop evenly.
</div>

---

# Build it up

```js
sound("bd")           // one kick, filling the whole loop
```

```js
sound("bd sd")        // kick then snare — half the loop each
```

```js
sound("bd sd hh cp")  // four things — a quarter each
```

```js
sound("bd*4")         // shorthand: kick, four times
```

```js
sound("bd ~ sd ~")    // ~ is a rest. Silence takes a slot too.
```

<div v-click class="pt-6 text-xl">

**Add one more thing and everything gets faster.**<br>
<span class="opacity-70 text-base">Because it still has to fit in the same loop.</span>

</div>

<!--
Play each one. Ask "what happens if I add one more?" BEFORE you do it.
That question is the whole lesson.
-->

---

# Two more

```js
sound("[bd sd] hh")   // brackets = a group squeezed into one slot
```

```js
sound("bd(3,8)")      // 3 hits spread evenly over 8 slots
```

<div class="pt-8 opacity-70">

Don't worry about the second one. Just know that<br>
**"3 hits spread over 8 slots" is how half of all dance music is built.**

</div>

---

# Layers

`stack()` plays patterns at the same time. That's how a track is built.

```js
stack(
  sound("bd*4"),        // kick
  sound("~ sd ~ sd"),   // snare on 2 and 4
  sound("hh*8")         // hats
)
```

<div v-click class="pt-6 text-xl">

Three lines. That's music.

</div>

<!--
Add one line at a time, playing after each. This is the "room leans in" moment.
-->

---

# One knob

A `.something()` on the end changes how it sounds.

```js
stack(
  sound("bd*4"),
  sound("~ sd ~ sd"),
  sound("hh*8").gain(0.4)   // ← hats were too loud
)
```

<div v-click class="pt-6">

There are dozens more — `.room()` reverb, `.lpf()` darker, `.delay()` echo.

**You will never memorise them. You don't have to.**

</div>

---
layout: statement
---

# That's everything<br>I'm going to teach you about Strudel

<div class="pt-8 text-lg opacity-70">
From here, you ask the agent.<br>
Including asking it to <b>teach you</b>.
</div>

<!--
Live, in front of them:
  "Explain what sound('hh*8').gain(0.4) does, line by line."
  "How do I add reverb?"
This transition IS the lesson.
-->

---
layout: section
---

# 2 · How the agent reaches it

...and what it can't do

---

# What's actually happening

```mermaid {scale: 0.85}
flowchart LR
    A["🧑 You<br/>plain English"] --> B["🤖 Agent<br/>Claude Code · Codex"]
    B -->|"MCP"| C["🎛️ MCP server"]
    C -->|"drives"| D["🌐 Browser<br/>strudel.cc"]
    D --> E["🔊"]
```

<div v-click class="pt-8">

**MCP** is the middle arrow: a standard way to let an agent *reach a piece of software*.

</div>

<div v-click class="pt-4 text-lg">

Which is why it matters beyond today — **the Blender session is the same picture**,
with a different box at the end.

</div>

---
layout: statement
---

# Can it hear the music?

---

# Three levels

<div class="grid grid-cols-3 gap-4 pt-8">

<div class="p-4 rounded border border-green-500/40">
<div class="text-3xl">✅</div>
<div class="text-xl pt-2 font-bold">Reads your code</div>
<div class="opacity-70 pt-2 text-sm">Perfectly. It wrote most of it.</div>
</div>

<div class="p-4 rounded border border-green-500/40">
<div class="text-3xl">✅</div>
<div class="text-xl pt-2 font-bold">Measures the sound</div>
<div class="opacity-70 pt-2 text-sm">Is it playing? How loud? Where's the energy?</div>
</div>

<div class="p-4 rounded border border-red-500/40">
<div class="text-3xl">❌</div>
<div class="text-xl pt-2 font-bold">Judges it</div>
<div class="opacity-70 pt-2 text-sm">No ears. No taste. None.</div>
</div>

</div>

<div v-click class="pt-10 text-center text-2xl">

**So you are the ears.**

</div>

---

# Describe. Don't evaluate.

<div class="grid grid-cols-2 gap-8 pt-6">
<div>

### ❌ Wasted

> "That sounds bad. Fix it."

<div class="pt-4 opacity-70 text-sm">
It genuinely has no idea what you heard.
</div>

</div>
<div>

### ✅ Works

> "The drums feel too busy."

> "The bass is drowning the melody."

> "I want it slower and darker."

> "It gets boring after 8 bars."

</div>
</div>

<div v-click class="pt-8 text-center text-lg opacity-80">

Same skill in Blender. It can't see your render either.

</div>

---
layout: section
---

# 3 · Watch this

I don't know how to make reggae

<!--
SWITCH TO THE AGENT WINDOW. The MCP drives its own browser — not this deck.

Prompt:
  "I want to understand reggae. Teach me its important musical characteristics,
   and help me build a reggae track in Strudel. Build it one instrument at a time.
   Before you add each instrument, explain what role it plays in reggae and what
   makes it characteristic. Give me the code for each step and wait for me
   before continuing."

Full script + fallback patterns: docs/strudel/demo-reggae.md
Talk while it thinks. The latency is the teaching slot.
-->

---
layout: section
---

# 4 · Your turn

---

# Three ways to talk to it

<div class="pt-4 space-y-6">

<div class="p-4 rounded bg-gray-500/10">
<div class="text-xl">🎧 <b>MAKE</b></div>
<div class="opacity-80 pt-1">"Build me a reggae track — slow, heavy bass, guitar on the offbeat."</div>
</div>

<div class="p-4 rounded bg-gray-500/10">
<div class="text-xl">🎓 <b>TEACH ME</b></div>
<div class="opacity-80 pt-1">"I recognise reggae but don't know what defines it. Explain it, then help me build it."</div>
</div>

<div class="p-4 rounded bg-blue-500/15 border border-blue-500/40">
<div class="text-xl">🎛️ <b>GIVE ME OPTIONS</b></div>
<div class="opacity-80 pt-1">"At each step, offer me three changes, explain what each does musically, and wait for me to pick."</div>
</div>

</div>

<div v-click class="pt-6 text-center">

The third one is the one that's still useful tomorrow.

</div>

---

# If you don't know what to make

<div class="grid grid-cols-2 gap-6 pt-4 text-sm">
<div class="space-y-3">

> Make something that sounds like **two of my favourite artists collided**.

> Start with a kick. Add **one instrument at a time** — I'll say when.

> Build a track that **gets gradually stranger** over two minutes.

</div>
<div class="space-y-3">

> Take this happy track and make it **dark** — in three stages, so I hear it tip over.

> This is trip-hop. **Turn it into trance**, step by step, explaining what has to change.

> Give me **three versions** of this: hopeful, anxious, exhausted.

</div>
</div>

<div class="pt-8 text-center opacity-70">
More: <b>docs/strudel/prompts.md</b>
</div>

---
layout: statement
---

# 💾 The URL is the save button

<div class="pt-6 text-lg opacity-80">

Strudel puts your whole track **in the page URL**.

**Copy it. Paste it somewhere.** It replays exactly.

</div>

<div class="pt-8 text-base opacity-60">
Do it whenever you like something — before you keep editing.<br>
There is no undo after a refresh.
</div>

---
layout: iframe-right
url: https://strudel.cc/
---

# Go

<div class="pt-6 text-lg">

Make something.

I'm circulating — grab me.

</div>

<div class="pt-10 opacity-70">

**Last 15 minutes:** anyone who wants to plays ~30 seconds out loud.

Completely optional. It's the best part.

</div>

<!--
⚠️ Clicker won't work here either — click this text column before using arrow keys.
Leave this slide up while you circulate.
-->

---
layout: center
class: text-center
---

# One last thing

<div class="pt-6 text-xl opacity-80">

You just pointed an AI agent at a piece of software you'd never used,<br>
and made it do something real.

</div>

<div v-click class="pt-8 text-2xl">

**That was MCP. It works on almost anything.**

</div>

<div v-click class="pt-6 text-lg opacity-70">

What would *you* point it at?

</div>
