#import "./colors.typ": *

#let poster_section(title, body, fill: false) = {
  let fill_color = if fill {bgcolor1} else {none}
  block(
    width: 100%,
    fill: fill_color,
    inset: 20pt,
    radius: 10pt,
    stack(
      align(center)[== #title],
      v(0.15em),
      line(length: 100%, stroke: (paint: bgcolor2, thickness: 3pt, cap: "round")),
      v(0.6em),
      [#body],
      v(0.3em)
    )
  )
}


#let poster_header(title, author, mentor, subtitle) = {
  set text(
    fill: scolor2
  )
  stack(
    dir: ttb,
    block(
      fill: bgcolor2,
      width: 100%,
      height: 100%,
      inset: 0.5in,
      grid(
        columns: (1fr, 4fr, 1fr),
        [],
        align(center + horizon)[#stack(
          spacing: 0.5in,
          text(size: 72pt, weight: "extrabold")[#title],
          text(size: 48pt)[
            #stack(dir: ltr, spacing: 0.5in, [#author --- Mentor: #mentor])
          ],
          text(size: 36pt)[#subtitle]
        )],
        align(center + horizon)[#image("assets/whitelogo.png", height: 100%)]
      )
    ),
  )

}


#let poster_footer() = {
  stack(
    dir: ttb,
    block(
      fill: bgcolor2,
      width: 100%,
      height: 100%
    )
  )

}


#let poster(title, author, mentor, subtitle, doc) = {
  set page(
    height: 32.5in,
    width:  43in,
    margin: 0in,
  )

  set text(
    fill: scolor1
  )

  show heading.where(level: 2): it => [
    #set text(40pt, fill: bgcolor2)
    #it
    #v(0.3em)
  ]

  show strong: it => [
    #set text(fill: scolor1)
    #it
  ]

  grid(
    columns: 1,
    rows: (14%, 82%, 4%),
    poster_header(title, author, mentor, subtitle),
    doc,
    poster_footer()
  )
}
