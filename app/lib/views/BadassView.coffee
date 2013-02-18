""" Cranky, just lost file with comment grrrrr
"""
module.exports.BadassView = class BadassView extends Backbone.View

  logging: on

  autoSetConstructorArgs: on

  constructor: (args) ->

    if @autoSetConstructorArgs
      for own attr, value of args
        @[attr] = value

    if @logging
      @turnOnLogging()

    # called so backbone wires up & calls initialize
    Backbone.View::constructor.apply(@, arguments)

  turnOnLogging: ->
    @viewTypeName = @constructor.name

    if @initialize?
      @initialize = _.wrap @initialize, (fn, args) ->
        $log "#{@viewTypeName}.init", args
        fn.call @, args

    if @render?
      @render = _.wrap @render, (fn, args) ->
        $log "#{@viewTypeName}.render", args
        fn.call @, args

    if @save?
      @save = _.wrap @render, (fn, args) ->
        $log "#{@viewTypeName}.save", args
        fn.call @, args