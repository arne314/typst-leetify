#import "@preview/cmarker:0.1.6": render

// hacky way to evaluate code in readme
#{
  let source = read("/README.md")
  source = source.replace(regex("```typ"), "<!--raw-typst ")
  source = source.replace(regex("```[^typ]"), "-->")
  render(source)
}

