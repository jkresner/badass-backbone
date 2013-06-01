BB = require 'badass-backbone'

# terse syntax for adding objects (in this case models)
# that will be visible outside this file
exports = {}


# 1) Defined model on the exports object to it automatically gets exported
# 2) Inherit from Backbone BadassModel (BB.BadassModel) to get logging etc.
class exports.Company extends BB.BadassModel

# Dito above
class exports.Employee extends BB.BadassModel
  tagsString: ->
    t = @get 'tags'
    return '' if !t? || t.length is 0
    return t[0].name if t.length is 1
    i = 0
    ts = t[0].name
    for i in [1..t.length-1]
      if i is t.length - 1
        ts += " & #{t[i].name}"
      else
        ts += ", #{t[i].name}"
    ts

# How we automatically export our Company & Employee model definitions
module.exports = exports