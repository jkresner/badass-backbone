exports = {}

BB = require 'badass-backbone'
M = require './models'


class exports.Tags extends BB.FilteringCollection
  model: M.Tag


module.exports = exports