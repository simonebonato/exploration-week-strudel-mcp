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

## ⚠️ Rehearsal items — do not skip

1. **Your clicker will not work on the live-Strudel slides.** Keyboard events don't cross
   into a cross-origin iframe. Nothing steals your typing (good), but you also lose slide
   navigation while focus is in Strudel. **Advance those slides by mouse-click** — click
   the text column first, then arrow keys work again.

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
