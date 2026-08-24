# Start Here 🎧

Everything you need for the Strudel session, on one page. You don't need to know how to
code, how to make music, or what any of this is yet.

**What you're going to do:** type a request in plain English to an AI agent, and a browser
will start making music. Then you'll take over and make something of your own.

> **Curious what this looks like?**
> [**2 Minute Deep Acid in Strudel (from scratch)**](https://www.youtube.com/watch?v=HkgV_-nJOuE)
> by Switch Angel — someone building a track live, from an empty page, one line at a time. You'll hear each
> line the moment it's typed. That's Strudel.

> [!IMPORTANT]
> **Do the "Before the workshop" bit at home.** It takes ~10 minutes and involves three
> installs. Doing it in the room, on room wifi, with 20 other people, is much less fun.

---

## Before the workshop (~10 min, at home)

### 1. Install Node.js 22 or newer

Node is a program that runs other programs. You won't interact with it directly.

| Your computer | Do this |
| --- | --- |
| **Windows** | Download the installer from [nodejs.org](https://nodejs.org) and run it. Click through, accept the defaults. |
| **Mac** | Download the installer from [nodejs.org](https://nodejs.org) and run it. |

**Check it worked.** Open a terminal:
- **Windows:** press Start, type `PowerShell`, hit Enter.
- **Mac:** press Cmd+Space, type `Terminal`, hit Enter.

Type this and press Enter:

```
node -v
```

You should see something like `v22.22.2`. **If the number after `v` is 22 or higher,
you're good.** If it's lower, or you get an error, install again from the link above.

### 2. Install your AI agent

You'll ask the music server for sounds through an AI agent. For this workshop we support
**Claude Code** and **Codex**. Install **one** of them:

| Agent | Install command |
| --- | --- |
| **Claude Code** | `npm install -g @anthropics/claude-code` |
| **Codex** | `npm install -g @openai/codex` |

In the same terminal window, type the command for the agent you chose and press Enter.
You'll be told before the workshop which one to use; if you aren't sure, pick **Claude
Code**.

**Check it worked.** Type:

```
claude --version
```

or

```
codex --version
```

depending on which you installed. You should see a version number, not an error.

### 3. Install the music server

In that same terminal window, type this and press Enter:

```
npm install -g @williamzujkowski/live-coding-music-mcp@4.0.0
```

> [!TIP]
> **You can skip the browser install.** The MCP server usually downloads Chromium
> automatically the first time it runs. If it does, you're done. If the agent later says the
> browser is missing, run the command below — it downloads ~180 MB and takes a couple of
> minutes.
>
> **Mac:**
> ```
> node "$(npm root -g)/@williamzujkowski/live-coding-music-mcp/node_modules/playwright/cli.js" install chromium --no-shell
> ```
>
> **Windows (PowerShell):**
> ```
> node "$(npm root -g)\@williamzujkowski\live-coding-music-mcp\node_modules\playwright\cli.js" install chromium --no-shell
> ```
>
> A warning about *"install your dependencies first"* is harmless. Ignore it.

### 4. Connect it to your AI agent

You'll be told before the workshop which agent to use. Run **one** of these:

**On Mac** — run one of these:
```
claude mcp add strudel -- live-coding-music-mcp
```
```
codex mcp add strudel -- live-coding-music-mcp
```

**On Windows** — use this longer form instead. It looks fussy, but it avoids two known
Windows bugs, and it's the version that reliably works. First run:

```
npm root -g
```

That prints a folder, something like `C:\Users\you\AppData\Roaming\npm\node_modules`.
Paste **your** folder into the command below, replacing the example path:

```
claude mcp add strudel -- node "C:\Users\you\AppData\Roaming\npm\node_modules\@williamzujkowski\live-coding-music-mcp\dist\index.js"
```
```
codex mcp add strudel -- node "C:\Users\you\AppData\Roaming\npm\node_modules\@williamzujkowski\live-coding-music-mcp\dist\index.js"
```

> [!TIP]
> Let the command write the config for you. **Don't hand-edit the config file on Windows** —
> backslashes in paths get mangled and it fails in a confusing way.

### 5. Check it worked

**Claude Code:** run `claude mcp list` → you want to see `strudel` and the word
**Connected**.

**Codex:** run `codex mcp list` → you want to see `strudel` and the word **enabled**.

Then **start a fresh session** with your agent and type:

> Initialize Strudel and play a four-on-the-floor kick drum.

A browser window should open by itself and you should hear a kick drum.

**Heard it? You're done. See you at the workshop.** 🎉

**No sound?** Click once inside the browser window that opened — browsers block audio until
you interact with them. Still nothing? Jump to [Nothing works](#nothing-works) below, and
bring it to the workshop; we'll fix it in the first 15 minutes.

---

## Bring with you

- 🎧 **Headphones.** Twenty laptops playing techno at once is a genuinely bad time.
- 🖱️ **A mouse** (mainly for the Blender session).
- 💻 Your laptop, charged, with the steps above done.

---

## On the day

### The one idea you need about Strudel

Anything **in quotes** is a pattern that fills **one loop**. Whatever you put in it splits
that loop evenly.

```js
sound("bd sd")      // kick, then snare — half the loop each
sound("bd*4")       // kick four times — a quarter each
sound("bd ~ sd ~")  // ~ is a rest. Silence gets a slot too.
```

That's it. Everything else is stacking those and adding effects. If you understand this
much, you can *read* what the agent writes — which is what lets you direct it.

Play with it yourself: **[strudel.cc](https://strudel.cc)** — Ctrl/Cmd+Enter plays,
Ctrl/Cmd+`.` stops.

### Three ways to talk to your agent

Most people only use the first one. The third is the one worth keeping.

| Mode | Example |
| --- | --- |
| 🎧 **MAKE** | *"Build me a reggae track — slow, heavy bass, guitar on the offbeat."* |
| 🎓 **TEACH ME** | *"I recognise reggae but don't know what defines it. Explain it, then help me build it."* |
| 🎛️ **GIVE ME OPTIONS** | *"At each step, offer me three changes, explain what each does musically, and wait for me to pick."* |

👉 **Full list of prompts to steal: [prompts.md](../strudel/prompts.md)**

### Your agent cannot hear the music

It can read the code. It can even measure the sound (is it playing? too bassy?). But it
**cannot tell whether it sounds good.** It has no ears and no taste.

So don't say *"that sounds bad, fix it."* It has no idea what you heard. Say what you
actually noticed:

> "The drums feel too busy." · "The bass is drowning out the melody." ·
> "I want it slower and darker." · "It gets boring after 8 bars."

**You are the ears.** That's your job in this collaboration.

### Save what you like — this one matters

Strudel puts your entire track **into the page URL**. So saving is just:

> **Copy the URL. Paste it somewhere.** (Notes app, message to yourself, anywhere.)

That URL replays your track exactly. Do it *whenever you make something you like*, before
you keep editing — there's no undo after a refresh.

You can also ask your agent: *"Save this version as reggae-v2."*

### Last 15 minutes

Anyone who wants to plays ~30 seconds of what they made, out loud, to the room. Entirely
optional — but it's the best part, and everyone's sounds completely different.

---

## Nothing works

Work down this list. Most problems are the first three.

| What's happening | Try this |
| --- | --- |
| **No sound**, but the browser is open and something looks like it's playing | **Click once inside the browser window.** Browsers mute pages until you interact with them. Then check your volume and that headphones are actually selected. |
| The agent changed the code but the **music didn't change** | Press the **`update`** button at the top right of strudel.cc (or Ctrl/Cmd+Enter in the editor). |
| The browser window **closed or crashed**, and now every request fails | **Don't ask the agent to initialize again — that won't fix it**, and the agent will happily tell you everything is fine. Reconnect the server instead: in Claude Code type **`/mcp`** and reconnect; in Codex, quit and start a fresh session. *(Try not to close that browser window in the first place — the agent can't reopen it.)* |
| Agent says it **can't find the tools** / server not connected | Close your agent completely and start a fresh session — tools only load at startup. If still missing, re-run step 3. |
| **Windows:** server won't start, or "timed out" | You probably registered the short name. Re-register using the `node "C:\...\dist\index.js"` form in step 3 — that's exactly what it's for. |
| Everything is **weirdly slow or two browser windows** appeared | You have two agents running. Quit one — each one starts its own browser. |
| `node -v` says **command not found** | Node didn't install, or your terminal needs restarting. Close the terminal, open a new one, try again. |

Still stuck? **Bring it to the workshop.** The first 15 minutes are set aside for exactly
this.

---

## Keep going after the workshop

- **[2 Minute Deep Acid in Strudel (from scratch)](https://www.youtube.com/watch?v=HkgV_-nJOuE)**
  by Switch Angel — watch someone build a whole track live from an empty page. Two minutes, and you can
  read most of it after today.
- **[Strudel's own interactive tutorial](https://strudel.cc/workshop/first-sounds/)** —
  click through it at your own pace. It's genuinely good.
- **[Strudel documentation](https://strudel.cc/learn/)** — every function, with a play
  button next to each example.
- **[awesome-strudel](https://github.com/terryds/awesome-strudel)** — real tracks people
  have made, with the code. Open one, hear it, read it, steal from it.
- And remember: your agent will teach you any of it. *"Explain what this line does."*
