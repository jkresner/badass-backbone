FilteringCollection = require './FilteringCollection'


""" PagingAndFilterCollection
  (1) Can keep track of current page & return it using fetchpage() """

class PagingCollection extends FilteringCollection

  pagesize: 25          # can override in the child collection

  # Again wire into coffee ctor to make sure we hook up events and still let
  # child class use Backbone.Collection.initialize for it's own init code
  constructor: (args) ->
    # Called FilteringCollection ctor with calls Backbone.Collection ctor
    FilteringCollection::constructor.apply(@, arguments)
    # If we filter or sort the collection we go back to page one as the
    # number of pages will most likely have changed
    @on 'filter sort', @resetpaging, @

  # Override base reset_filteredmodels and combine it with reset paging
  reset_filteredmodels: ->
    FilteringCollection::reset_filteredmodels.apply(@, arguments)
    @resetpaging()

  # Recalculate our total pages and reset our current page back to 1
  resetpaging: ->
    @totalpages = Math.ceil(@filteredmodels.length / @pagesize)
    @currentpage = if @totalpages > 0 then 1 else 0

  # Move to next, previous or a specific page number
  setpage: (page) ->
    if page is '»' && @currentpage < @totalpages then @setpage @currentpage+1
    else if page is '«' && @currentpage > 1 then @setpage @currentpage-1
    else
      page = parseInt page
      if page <= @totalpages && page > 0
        @currentpage = page
        @trigger('page')

  # Return the models in the current page
  fetchpage: ->
    start = @pagesize * (@currentpage - 1)
    _.first _.rest(@filteredmodels, start), @pagesize


module.exports = PagingCollection

