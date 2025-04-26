#import "./template.typ": *

#show: poster.with(
  "Basic Construction of Coxeter Groups",
  "Nate Annau and Jesse Cobb",
  "Benedict Lee",
  "University of California, Santa Barbara"
)

#set par(justify: true)
#set text(
  font: "Libertinus Serif",
  size: 24pt,
)

#pad(
  grid(
    columns: 3,
    inset: 0.5in,
    gutter: 30pt,
    [
      #poster_section("First Section", [
        #lorem(300)
      ])

      #poster_section("Second Section", [
        #lorem(300)
      ])
    ],
    [
      #poster_section("Third Section", [
        #lorem(500)
      ])
    ],
    [#lorem(600)]
  ),
  x: 1in,
)
