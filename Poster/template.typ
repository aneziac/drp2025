#let bgcolor1 = rgb("#b2eeee")
#let bgcolor2 = rgb("#144a35")
#let scolor1  = black
#let scolor2  = white
#let acolor   = rgb(254, 188, 17)

#let statement(
  name,
  statement,
  breakable:    false,
  width:        100%,
  height:       auto,
) = context {
  let name_content = block(
    fill: bgcolor2,
    inset: 7pt,
    width: 100%,
    text(scolor2)[*#name*]
  )
  let block_inset = 0pt
  let top_pad     = 8pt
  let side_pad    = 12pt
  let bottom_pad  = 10pt
  let radius      = 7pt

  block(
    fill: bgcolor1,
    width: width,
    height: height,
    inset: block_inset,
    radius: radius,
    stroke: scolor1,
    breakable: breakable,
    clip: true,
    stack(
      name_content,
      pad(
        top: top_pad,
        bottom: bottom_pad,
        left: side_pad,
        right: side_pad,
        statement
      )
    )
  )
}

#let poster_section(title, body, fill: false) = {
  let fill_color = if fill {rgb("#cde5ce")} else {none}
  block(
    width: 100%,
    fill: fill_color,
    inset: 25pt,
    radius: 20pt,
    stack(
      align(center)[== #title],
      v(0.5em),
      line(length: 100%),
      v(1em),
      [#body]
    )
  )
}


#let poster_header(title, author, mentor, subtitle) = {
  set text(
    fill: scolor2
  )
  block(
    fill: bgcolor2,
    width: 100%,
    height: 100%,
    stroke: scolor1,
    inset: 0.5in,
    grid(
      columns: (1fr, 4fr, 1fr),
      [],
      align(center + horizon)[#stack(
        spacing: 0.5in,
        text(size: 72pt, weight: "extrabold")[#title],
        text(size: 48pt)[
          #stack(dir: ltr, spacing: 0.5in, [#author], [Mentor: #mentor])
        ],
        text(size: 36pt)[#subtitle]
      )],
      align(center + horizon)[#image("assets/whitelogo.png", height: 100%)]
    )
  )
}


#let poster_footer() = {
  block(
    fill: bgcolor2,
    width: 100%,
    height: 100%
  )
}


#let poster(title, author, mentor, subtitle, doc) = {
  set page(
    height: 32.5in,
    width:  43in,
    margin: 0in,
  )

  set text(
    font: "New Computer Modern Sans",
    fill: rgb("#2f0707")
  )

  show heading.where(level: 2): it => [
    #set text(40pt, fill: rgb("#074c01"))
    #it
    #v(0.3em)
  ]

  show strong: it => [
    #set text(fill: rgb("#021300"))
    #it
  ]

  grid(
    columns: 1,
    rows: (15%, 80%, 5%),
    poster_header(title, author, mentor, subtitle),
    doc,
    poster_footer()
  )
}
