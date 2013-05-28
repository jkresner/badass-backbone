BB = require 'badass-backbone'
Models = require './models'


class exports.Teas extends BB.FilteringCollection
  model: Models.Tea


module.exports = exports