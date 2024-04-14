// https://github.com/typst/typst/issues/1987#issuecomment-1690672386

#let Typst = {
  text(font: "Linux Libertine", weight: "semibold", fill: eastern)[typst]
}

#let LaTeX = {
    set text(font: "New Computer Modern")
    box(width: 2.55em, {
      [L]
      place(top, dx: 0.3em, text(size: 0.7em)[A])
      place(top, dx: 0.7em)[T]
      place(top, dx: 1.26em, dy: 0.22em)[E]
      place(top, dx: 1.8em)[X]
    })
}
