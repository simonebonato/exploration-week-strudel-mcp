# Slides — Slidev deck

## Run it

```bash
cd slides
npm install          # first time only
npm run dev          # opens http://localhost:3030
```

Build a standalone offline copy (do this before the workshop):

```bash
npm run build        # → slides/dist/, works with no network
```

## Let your agent edit the deck

Slidev ships its own MCP server, plus an official agent skill. This is a second, quieter
MCP example — the same "you type, the browser changes" shape as Strudel.

```bash
npx skills add slidevjs/slidev                                   # Claude Code + Codex
claude mcp add --transport http slidev http://localhost:3030/__mcp   # dev server running
```

Then: *"Add a slide after the three-modes one showing the seed prompts."*

## Live Strudel pads (slides 8–11)

Slides 8–11 — *Build it up · Two more · Layers · One knob* — each carry a `<StrudelPad>`:
a small Strudel REPL docked into the slide, so you can play the examples **without leaving
the deck**. Click **▶ Live Strudel** bottom-right, then click a chip to load and play that
snippet. The editor is live — type in it, `Ctrl/Cmd+Enter` to re-run, `Ctrl/Cmd+.` to stop.

Snippets live in [`components/strudelPresets.js`](components/strudelPresets.js), one named
set per slide. To add a set: add a key there, then `<StrudelPad preset="yourkey" />` in
`slides.md`. **Don't** pass code inline in the markdown — double quotes can't be escaped
inside a Vue attribute and the build fails.

This is **not** an iframe to strudel.cc. It's the `@strudel/repl` web component
(`<strudel-editor>`, pinned **1.3.0**) running in the deck's own page, which is what makes
instant snippet-swapping and real ▶/■ buttons possible. Three consequences:

- **Editors are created only when you open a pad.** Opening the first one takes a moment
  while the Strudel engine loads. Open one early to warm it.
- **Only one pad plays at a time** (the component's `solo` mode) — opening another or
  hitting ▶ elsewhere stops the previous one.
- **It is a different Strudel build from strudel.cc.** Fine for these five-token examples;
  don't assume exotic functions match.

### ⚠️ The pads need network — the offline build does not cover them

`slidev build` produces an offline SPA, **but the pads are an exception.** Strudel fetches
its sample maps from `raw.githubusercontent.com` on first play and there's no service worker
caching them. **Verified 2026-08-20:** with external requests blocked, clicking a chip does
nothing at all — the scheduler never starts.

**Mitigation:** open all four pads and play at least one chip on each **while you have
wifi**, on the machine and browser profile you'll present from. Same rule as the strudel.cc
sample cache, different mechanism. If the wifi dies, slide 6's strudel.cc iframe is the
PWA-cached fallback.

## ⚠️ Rehearsal items — do not skip

1. **Your clicker will not work on slide 6 (the strudel.cc iframe).** Keyboard events don't
   cross into a cross-origin iframe. Nothing steals your typing (good), but you also lose
   slide navigation while focus is in Strudel. **Advance that slide by mouse-click** — click
   the text column first, then arrow keys work again.

   **The pads on slides 8–11 are different and safer.** They're in the deck's own page, so
   `StrudelPad` traps keydown/keyup at the panel root. This is load-bearing, not decorative:
   Slidev binds its shortcuts to `window` via `useMagicKeys` and its ignore-list is only
   `INPUT`/`TEXTAREA`/`BUTTON`/`A` — CodeMirror is a **contenteditable div**, so without the
   trap, typing `sound("bd*4")` would fire `d` (dark mode) and `o` (overview) mid-demo.
   **Verified 2026-08-20:** pressing `d` outside a pad flips the deck to dark; typing the
   same character inside a pad changes nothing but the code. Click the slide (not the pad)
   to get arrow keys back.

2. **Add `allow="autoplay"` for slides that must make noise.** The `layout: iframe-right`
   used here sets no `allow=` attribute. Audio worked in testing anyway, but if a slide
   must be reliable, write the iframe by hand:

   ```html
   <iframe src="https://strudel.cc/" allow="autoplay"
           style="width:100%;height:75vh;border:0"></iframe>
   ```

3. **The MCP cannot drive the slide's iframe.** The Strudel MCP server drives its *own*
   Playwright Chromium window — a different browser context. The reggae demo happens in
   that window, not in the deck. This is true of every deck tool; plan the switch.

4. **Warm the sample cache online.** strudel.cc caches the app on first visit, but samples
   cache only when actually played. Play every sound in the demo while you still have wifi.

5. **Preload a pattern into a slide** with `https://strudel.cc/#<base64-of-the-code>` — the
   same URL form students use to save their work.

## Speaker notes

Every `<!-- ... -->` block in `slides.md` is a presenter note — press `p` in dev mode for
presenter view. The reggae demo's full script lives in
[`../docs/strudel/demo-reggae.md`](../docs/strudel/demo-reggae.md).
