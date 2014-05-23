""" BadassView add 3 basic bits of functionality to a normal Backbone.View
    1) Auto-logging of initialize, render & save
    2) Auto setting constructor args as attributes on view instances
    3) Short elm() to access an html element based on it's name attribute
"""
module.exports = class BadassView extends Backbone.View

  # Set logging on /off
  # Why? : During dev it's handy to see the flow your views execute in
  logging: off

  # Set autoSetConstructorArgs on /off
  # Why? : If you tend to write left hand, right hand assignment in
  #        initialize stop! autoSetConstructorArgs is a convention to
  #        set key /values passed to the constructor just like
  #        'model' & 'collection' is by default by backbone.
  autoSetConstructorArgs: on


  constructor: (args) ->

    # allow to set autoSetConstructorArgs via instance constructor
    if args? && args.autoSetConstructorArgs?
      @autoSetConstructorArgs = args.autoSetConstructorArgs

    # assign each key/value passed in onto the view instance
    if @autoSetConstructorArgs
      for own attr, value of args
        @[attr] = value

    # wire up auto logging
    @enableLogging() if @logging

    # Call backbone to correctly wire up & call View.initialize
    Backbone.View::constructor.apply(@, arguments)


  enableLogging: ->

    # Get type name of the view to distinguish it in log statements
    @viewTypeName = @constructor.name

    if @initialize?
      @initialize = _.wrap @initialize, (fn, args) =>
        $log "#{@viewTypeName}.init", args
        fn.call @, args

    if @render?
      @render = _.wrap @render, (fn, args) =>
        $log "#{@viewTypeName}.render", "model", @model, "collection", @collection
        fn.call @, args

    if @save?
      @save = _.wrap @save, (fn, args) =>
        $log "#{@viewTypeName}.save", args
        fn.call @, args

  # Promote using name attribute instead of id and being
  # strict about only looking inside the view's DOM scope
  elm: (attr) ->
    @$("[name='#{attr}']")

  mget: (attr) ->
    @model.get(attr) if @model?