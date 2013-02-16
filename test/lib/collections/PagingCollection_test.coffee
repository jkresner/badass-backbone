# docs on using spy/fake/stub                   sinonjs.org/docs/
# docs on expect syntax                         chaijs.com/api/bdd/
# docs on sinon chai syntax                     chaijs.com/plugins/sinon-chai
{_, $, $log, Backbone} = window
hlpr = require './../../helper'
BB = require 'lib/badassbackbone'


class ExampleCollection extends BB.PagingCollection
  pageSize: 5


describe 'BB.PagingCollection => ', ->

  beforeEach ->
    hlpr.clean_setup @
    @c = new ExampleCollection()
    @twelveitems = [
      { id: 1, char: 'a', num: 123 }
      { id: 2, char: 'f', num: 223 }
      { id: 3, char: 'b', num: 143 }
      { id: 4, char: 'e', num: 153 }
      { id: 5, char: 'b', num: 173 }
      { id: 6, char: 'c', num: 183 }
      { id: 7, char: 'd', num: 193 }
      { id: 8, char: 'g', num: 123 }
      { id: 9, char: 'h', num: 223 }
      { id: 10, char: 'i', num: 143 }
      { id: 11, char: 'j', num: 153 }
      { id: 12, char: 'k', num: 173 }
    ]

  it 'reset calls resetFlteredModels once + resetPaging once', ->
    @spys.resetPaging = sinon.spy ExampleCollection::, "resetPaging"
    @spys.resetFilteredModels = sinon.spy ExampleCollection::, "resetFilteredModels"
    c = new ExampleCollection()
    c.reset [{char: 'l', num: 143},{char: 'x', num: 143}]
    expect(@spys.resetPaging.calledOnce).to.equal true
    expect(@spys.resetFilteredModels.calledOnce).to.equal true

  it 'on reset, current & total pages set to 1 and 1 with 5 items and page size 5', ->
    @c.reset [{ id: 1 },{ id: 2 },{ id: 3 },{ id: 4 },{ id: 5 }]
    expect(@c.currentPage).to.equal 1
    expect(@c.totalPages).to.equal 1

  it 'on reset with 12 items and page size 5, currentPage is 1 & totalPages 3', ->
    @c.reset @twelveitems
    expect(@c.currentPage).to.equal 1
    expect(@c.totalPages).to.equal 3

  it 'page size for 7 models in 5 pagesize is 2', ->
    @c.reset [{ id: 1 },{ id: 2 },{ id: 3 },{ id: 4 },{ id: 5 },{ id: 6 },{ id: 7 }]
    expect(@c.currentPage).to.equal 1
    expect(@c.totalPages).to.equal 2

  it 'setNext/setpage(») with 1 page doesnt move anywhere', ->
    @c.reset [{ id: 1 },{ id: 2 },{ id: 3 }]
    expect(@c.totalPages).to.equal 1
    @c.setPage('»')
    expect(@c.currentPage).to.equal 1

  it 'setNext/setpage(») with 1 page doesnt move anywhere', ->
    @c.reset [{ id: 1 },{ id: 2 },{ id: 3 }]
    @c.setPage('«')
    expect(@c.currentPage).to.equal 1

  it 'setpage(3) with 3 pages moves to page 3', ->
    @c.reset @twelveitems
    expect(@c.totalPages).to.equal 3
    expect(@c.currentPage).to.equal 1
    @c.setPage(3)
    expect(@c.currentPage).to.equal 3

  it 'setpage("3") with 3 pages moves to page 3', ->
    @c.reset @twelveitems
    expect(@c.totalPages).to.equal 3
    expect(@c.currentPage).to.equal 1
    @c.setPage("3")
    expect(@c.currentPage).to.equal 3

  it 'setNext with 2 pages moves to page 2', ->
    @c.reset [{ id: 1 },{ id: 2 },{ id: 3 },{ id: 4 },{ id: 5 },{ id: 6 },{ id: 7 }]
    expect(@c.currentPage).to.equal 1
    @c.setPage('»')
    expect(@c.currentPage).to.equal 2

  it 'setPrev from page 3 moves to page 2', ->
    @c.reset @twelveitems
    @c.setPage(3)
    @c.setPage('«')
    expect(@c.currentPage).to.equal 2

  it 'fetchPage on 1 of 3 returns a, f, b, e, b', ->
    @c.reset @twelveitems
    models = @c.fetchPage()
    chars = _.map models, (m) -> m.get 'char'
    expect(chars).to.deep.equal ['a', 'f', 'b', 'e', 'b']

  it 'fetchPage on 2 of 3 returns c, d, g, h, i', ->
    @c.reset @twelveitems
    @c.setPage('»')
    models = @c.fetchPage()
    chars = _.map models, (m) -> m.get 'char'
    expect(chars).to.deep.equal ['c', 'd', 'g', 'h', 'i']

  it 'fetchpage on 5 of 3 returns j, k', ->
    @c.reset @twelveitems
    @c.setPage(3)
    models = @c.fetchPage()
    chars = _.map models, (m) -> m.get 'char'
    expect(chars).to.deep.equal ['j', 'k']

  afterEach ->
    hlpr.clean_tear_down @