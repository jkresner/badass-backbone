BB = require 'badass-backbone'

# terse syntax for adding objects (in this case models)
# that will be visible outside this file
exports = {}


# 1) Defined model on the exports object to it automatically gets exported
# 2) Inherit from Backbone BadassModel (BB.BadassModel) to get logging etc.
class exports.Company extends BB.BadassModel

# Dito above
class exports.Employee extends BB.BadassModel


# How we automatically export our Company & Employee model definitions
module.exports = exports