#let bgcolor1 = white
#let bgcolor2 = rgb(0, 54, 96)
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
  let top_pad = 8pt
  let side_pad = 12pt
  let bottom_pad = 10pt
  let radius = 7pt

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


#let poster_header(title) = {
  return [#title]
}


#let poster(title, doc) = {
  set page(
    paper: "us-letter",
    header: poster_header(title),
    height: 32.5in,
    width: 43in,
    columns: 3,
  )
  set par(justify: true)
  set text(
    font: "Libertinus Serif",
    size: 24pt,
  )

  image("assets/logo.png")

  doc
}
