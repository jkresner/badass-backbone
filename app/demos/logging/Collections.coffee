sexports = {}
BB = require './../../lib/badassbackbone'
Models = require './Models'


class exports.Teas extends BB.FilteringCollection
  model: Models.Tea


module.exports = exports