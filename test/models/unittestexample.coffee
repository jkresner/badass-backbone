{expect, Backbone} = require './../test-lib-setup'
global.Backbone = Backbone


class Developer extends Backbone.Model
  tagsString: ->
    t = @get 'tags'
    return '' if !t? || t.length is 0
    return t[0].name if t.length is 1
    i = 0
    ts = t[0].name
    for i in [1..t.length-1]
      if i is t.length - 1
        ts += " & #{t[i].name}"
      else
        ts += ", #{t[i].name}"
    ts


describe "UI models shared", ->

  it "tagsString returns empty string for null tags", ->
    m = new Developer()
    expect( m.tagsString() ).to.equal ''

  it "tagsString returns empty string for 0 length tags", ->
    m = new Developer tags: []
    expect( m.tagsString() ).to.equal ''

  it "tagsString returns single string for 1 length tags", ->
    m = new Developer tags: [{name:'backbone'}]
    expect( m.tagsString() ).to.equal 'backbone'

  it "tagsString returns and separated string for 1 length tags", ->
    m = new Developer tags: [{name:'backbone'},{name:'underscore'}]
    expect( m.tagsString() ).to.equal 'backbone & underscore'

  it "tagsString returns commma and and separated string for 1 length tags", ->
    m = new Developer tags: [{name:'backbone'},{name:'underscore'},{name:'node'}]
    expect( m.tagsString() ).to.equal 'backbone, underscore & node'

  it "tagsString returns commma and and separated string for 1 length tags", ->
    m = new Developer tags: [{name:'backbone'},{name:'underscore'},{name:'node'},{name:'mongo'}]
    expect( m.tagsString() ).to.equal 'backbone, underscore, node & mongo'