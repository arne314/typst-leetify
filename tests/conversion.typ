#import "@preview/leetify:0.1.0": convert-from-leet, convert-to-leet

#{
  let words = read("/README.md").split(regex("\s+"))
  for word in words {
    word = lower(word.replace(regex("\d"), "a"))
    let leet = convert-to-leet(word)
    [#word $->$ #leet\ ]
    assert(convert-from-leet(convert-to-leet(word)) == word)
  }
}

