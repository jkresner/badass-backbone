exports = {}
BB = require './../../lib/badassbackbone'
Models = require './Models'


class exports.JSDevelopers extends BB.FilteringCollection
  model: Models.Developer
  url: '/api/developers?skill=js'


class exports.Developers extends BB.PagingCollection
  model: Models.Developer
  url: '/api/developers'



module.exports = exports