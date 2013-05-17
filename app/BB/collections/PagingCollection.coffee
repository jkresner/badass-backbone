FilteringCollection = require './FilteringCollection'


""" PagingAndFilterCollection
  (1) Can keep track of current page & return it using fetchpage() """

class PagingCollection extends FilteringCollection

  pageSize: 25          # can override in the child collection

  # Again wire into coffee ctor to make sure we hook up events and still let
  # child class use Backbone.Collection.initialize for it's own init code
  constructor: (args) ->
    # Called FilteringCollection ctor with calls Backbone.Collection ctor
    FilteringCollection::constructor.apply(@, arguments)
    # If we filter or sort the collection we go back to page one as the
    # number of pages will most likely have changed
    @on 'filter sort', @resetPaging, @

  # Override base reset_filteredmodels and combine it with reset paging
  resetFilteredModels: ->
    FilteringCollection::resetFilteredModels.apply(@, arguments)
    @resetPaging()

  # Recalculate our total pages and reset our current page back to 1
  resetPaging: ->
    @totalPages = Math.ceil(@filteredModels.length / @pageSize)
    @currentPage = if @totalPages > 0 then 1 else 0

  # Move to next, previous or a specific page number
  setPage: (page) ->
    if page is '»' && @currentPage < @totalPages then @setPage @currentPage+1
    else if page is '«' && @currentPage > 1 then @setPage @currentPage-1
    else
      page = parseInt page
      if page <= @totalPages && page > 0
        @currentPage = page
        @trigger 'page'

  # Return the models in the current page
  fetchPage: ->
    start = @pageSize * (@currentPage - 1)
    _.first _.rest(@filteredModels, start), @pageSize


module.exports = PagingCollection

