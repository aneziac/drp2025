#import "@local/superTemplate:0.3.0": *
#import "./template.typ": *
#import math_mod: *

#show: poster.with(
  "Basic Construction of Coxeter Groups",
  "Nate Annau and Jesse Cobb",
  "Benedict Lee",
  "University of California, Santa Barbara"
)

#set par(justify: true)
#set text(
  size: 24pt,
)
#show math.equation: set text(font: "New Computer Modern Math")

#let coxeter_systems = [
  #lorem(300)
]




#let chambers_and_nerves = [
]



#let basic_construction = [
  #lorem(600)
]

#let Davis_complex_CAT0 = [
  #lorem(400)
]

#let acknowledgements = [
  #lorem(25)
]

#let references = [
  #lorem(25)
]

#pad(
  grid(
    columns: 3,
    inset: 0.5in,
    gutter: 30pt,
    [
      #poster_section("Coxeter Systems", coxeter_systems)
      #poster_section("Chambers and Nerves", chambers_and_nerves, fill: true)
    ],
    [
      #poster_section("Basic Construction", basic_construction)
    ],
    [
      #poster_section([The Davis Complex is $"CAT"(0)$], Davis_complex_CAT0, fill: true)
      #poster_section("Acknowledgements", acknowledgements)
      #poster_section("References", references, fill: true)
    ]
  ),
  top: 0.5in,
  x: 1in,
)


