exports =

  # http://stackoverflow.com/questions/5636812/sorting-strings-in-reverse-order-with-backbone-js

  reversestring: (m, attr) ->
    if ! m.get(attr)? then return ''
    String.fromCharCode.apply String, _.map(m.get(attr).split(""), (c) -> 0xffff - c.charCodeAt() )
