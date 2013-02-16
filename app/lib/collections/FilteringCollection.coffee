""" FilteringCollection
  (1) Holds an original AND a filtered view of it's models
  (2) Can sort filtered models on any arbitrary attribute
      - sort can be invoked multiple times with different attributes to get
       sorted by A then B """

class FilteringCollection extends Backbone.Collection

  # Use coffee's constructor function so we can enforce initialization code +
  # let the child class use the standard Backbone initialize function to
  # execute it's own initialization code
  constructor: ->
    # when the collection is reset, we need to set the filtered models
    @on 'reset', @resetFilteredModels, @

    # Call Backbone.Collection ctor so backbone calls initialize function
    Backbone.Collection::constructor.apply(@, arguments)

  resetFilteredModels: ->
    @filteredModels = @models

  # We separate sorting from setting the filtered models & firing the sort event
  # This give flexibility to use sort in combination with filter below without
  # firing multiple events & causing views listening to both to render twice
  sortFilteredModels: (attr, direction, type) ->
    @filteredModels = @_sort attr, direction, type
    @trigger 'sort'

  # Implementation of bi-directional sort on any attribute of the models
  _sort: (attr, direction, type) ->
    if ! attr? then return @filteredModels

    if direction is 'up' || !direction? then @comparator = (m) -> m.get(attr)
    else if type is 'String' then @comparator = (m) -> reverseString(m, attr)
    else @comparator = (m) -> -1 * m.get(attr)

    _.sortBy @filteredModels, @comparator

  # Combine sort + filter & only trigger one event. We could still access _sort
  # & _filter separately if we want ... (f) = some custom object
  filterFilteredModels: (f) ->
    @filteredModels = @_filter f

    # Sort is an object like { attr: 'Name', direction: 'up', type: 'String' }
    if f? && f.sort?
      @filteredModels = @_sort f.sort.attr, f.sort.direction, f.sort.type

    @trigger 'filter'

  _filter: (f) ->

    console.log 'override _filter in child class'
    @models  # return non-implemented filter view of the models


# http://stackoverflow.com/questions/5636812/sorting-strings-in-reverse-order-with-backbone-js
reverseString = (m, attr) ->
  if ! m.get(attr)? then return ''
  String.fromCharCode.apply String, _.map( m.get(attr).split(""), (c) -> 0xffff - c.charCodeAt() )


module.exports = FilteringCollection

