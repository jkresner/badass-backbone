exports = {}

exports.clean_setup = (ctx) ->

  ctx.spys = {}
  ctx.stubs = {}


exports.clean_tear_down = (ctx) ->

  # restore all our spys & stubs
  for own attr, value of ctx.spys
    ctx.spys[attr].restore()

  for own attr, value of ctx.stubs
    ctx.stubs[attr].restore()


module.exports = exports
