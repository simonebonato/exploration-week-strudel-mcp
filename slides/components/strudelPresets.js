// Snippet sets for the <StrudelPad> on slides 8-11.
//
// Kept out of slides.md on purpose: code containing double quotes cannot be escaped
// inside a Vue attribute, and this stays readable/lintable as real JS.
//
// ⚠️ Every snippet here is played live on stage. Play-test the whole file before the
// session — see docs/rehearsal.md test 8.

export const presets = {
  // Slide 8 — "Build it up": one pattern, more things in it
  basics: [
    { label: 'bd', code: 'sound("bd")' },
    { label: 'bd sd', code: 'sound("bd sd")' },
    { label: 'bd sd hh cp', code: 'sound("bd sd hh cp")' },
    { label: 'bd*4', code: 'sound("bd*4")' },
    { label: 'bd ~ sd ~', code: 'sound("bd ~ sd ~")' },
  ],

  // Slide 9 — "Two more": brackets and euclidean rhythms
  more: [
    { label: '[bd sd] hh', code: 'sound("[bd sd] hh")' },
    { label: 'bd(3,8)', code: 'sound("bd(3,8)")' },
    { label: 'bd(5,8)', code: 'sound("bd(5,8)")' },
    {
      label: 'with hats',
      code: 'stack(\n  sound("bd(3,8)"),\n  sound("hh*8").gain(0.4)\n)',
    },
  ],

  // Slide 10 — "Layers": add one line at a time
  layers: [
    { label: 'kick', code: 'stack(\n  sound("bd*4")\n)' },
    { label: '+ snare', code: 'stack(\n  sound("bd*4"),\n  sound("~ sd ~ sd")\n)' },
    {
      label: '+ hats',
      code: 'stack(\n  sound("bd*4"),\n  sound("~ sd ~ sd"),\n  sound("hh*8")\n)',
    },
  ],

  // Slide 11 — "One knob": the first two chips ARE the slide
  knob: [
    {
      label: 'hats too loud',
      code: 'stack(\n  sound("bd*4"),\n  sound("~ sd ~ sd"),\n  sound("hh*8")\n)',
    },
    {
      label: '.gain(0.4)',
      code: 'stack(\n  sound("bd*4"),\n  sound("~ sd ~ sd"),\n  sound("hh*8").gain(0.4)\n)',
    },
    {
      label: '.room(0.5)',
      code: 'stack(\n  sound("bd*4"),\n  sound("~ sd ~ sd").room(0.5),\n  sound("hh*8").gain(0.4)\n)',
    },
    {
      label: '.lpf(500)',
      code: 'stack(\n  sound("bd*4"),\n  sound("~ sd ~ sd").room(0.5),\n  sound("hh*8").gain(0.4)\n).lpf(500)',
    },
  ],
}
