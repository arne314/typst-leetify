#let leet-map = (
  "a": "4",
  "e": "3",
  "g": "6",
  "i": "1",
  "o": "0",
  "s": "5",
  "t": "7",
)

#let leet-map-inv = (:)
#for (k, v) in leet-map {
  leet-map-inv.insert(v, k)
}

#let apply-map(st, map) = {
  assert(type(st) == str)
  let result = ""
  for codepoint in st.codepoints() {
    result += map.at(codepoint, default: codepoint)
  }
  return result
}

#let convert-to-leet(st) = {
  return apply-map(st, leet-map)
}

#let convert-from-leet(st) = {
  return apply-map(st, leet-map-inv)
}

#let leetify(body) = {
  show regex("\w+"): body => {
    if body.has("text") {
      convert-to-leet(body.text)
    } else {
      body
    }
  }
  body
}

