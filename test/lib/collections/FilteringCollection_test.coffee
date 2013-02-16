# docs on using spy/fake/stub                   sinonjs.org/docs/
# docs on expect syntax                         chaijs.com/api/bdd/
# docs on sinon chai syntax                     chaijs.com/plugins/sinon-chai
{_, $, $log, Backbone} = window
hlpr = require './../../helper'
BB = require 'lib/badassbackbone'


class ExampleCollection extends BB.FilteringCollection
  _filter: (f) ->     # Filter logic matches character & number greater than supplied num
    r = @models
    if f?
      if f.char?
        r = _.filter r, (m) => f.char is m.get('char')
      if f.num
        r = _.filter r, (m) => m.get('num') > f.num
    r


describe 'BB.FilteringCollection => ', ->

  beforeEach ->
    hlpr.clean_setup @
    @c = new ExampleCollection()
    @c.add new Backbone.Model char: 'a', num: 123
    @c.add new Backbone.Model char: 'f', num: 223
    @c.add new Backbone.Model char: 'b', num: 143
    @c.add new Backbone.Model char: 'e', num: 153
    @c.add new Backbone.Model char: 'b', num: 173
    @c.add new Backbone.Model char: 'c', num: 183
    @c.add new Backbone.Model char: 'd', num: 193


  it 'filtered models resets on collection reset', ->
    @spys.resetFilteredModels = sinon.spy ExampleCollection::, 'resetFilteredModels'
    c = new ExampleCollection()
    c.reset [ { char: 'z', num: 1 }, { char: 'y', num: 2 } ]
    expect(@spys.resetFilteredModels.calledOnce).to.be.true
    expect(c.filteredModels.length).to.equal 2

  it 'sorts backwards by character', ->
    filters =  { sort: { attr: 'char', direction: 'down', type: 'String' } }
    @c.filterFilteredModels filters
    results = @c.filteredModels
    expect(results[0].get('char')).to.equal 'f'
    expect(results[1].get('char')).to.equal 'e'
    expect(results[2].get('char')).to.equal 'd'
    expect(results[3].get('char')).to.equal 'c'
    expect(results[4].get('char')).to.equal 'b'
    expect(results[5].get('char')).to.equal 'b'
    expect(results[6].get('char')).to.equal 'a'

  it 'sorts ascending by number (num)', ->
    filters =  { sort: { attr: 'num', direction: 'up', type: 'Number' } }
    @c.filterFilteredModels filters
    results = @c.filteredModels
    expect(results[0].get('num')).to.equal 123
    expect(results[1].get('num')).to.equal 143
    expect(results[2].get('num')).to.equal 153
    expect(results[3].get('num')).to.equal 173
    expect(results[4].get('num')).to.equal 183
    expect(results[5].get('num')).to.equal 193
    expect(results[6].get('num')).to.equal 223


  it 'filters by character', ->
    filters =  { char: 'b' }
    @c.filterFilteredModels filters
    results = @c.filteredModels
    expect(results.length).to.equal 2
    expect(results[0].get('char')).to.equal 'b'
    expect(results[1].get('char')).to.equal 'b'


  it 'filters by number', ->
    filters =  { num: 175, sort: { attr: 'num', direction: 'up', type: 'Number' } }
    @c.filterFilteredModels filters
    results = @c.filteredModels
    expect(results.length).to.equal 3
    expect(results[0].get('num')).to.equal 183
    expect(results[1].get('num')).to.equal 193
    expect(results[2].get('num')).to.equal 223


  it 'character x number', ->
    filters =  { char: 'b', num: 150 }
    @c.filterFilteredModels filters
    results = @c.filteredModels
    expect(results.length).to.equal 1
    expect(results[0].get('char') is 'b' && results[0].get('num') is 173 ).to.be.true


  afterEach ->
    hlpr.clean_tear_down @