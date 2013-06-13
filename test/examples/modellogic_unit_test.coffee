M = require '/scripts/demos/spa/models'

describe "Model logic unit test example", ->

  it "tagsString returns empty string for null tags", ->
    m = new M.Employee()
    expect( m.tagsString() ).to.equal ''

  it "tagsString returns empty string for 0 length tags", ->
    m = new M.Employee tags: []
    expect( m.tagsString() ).to.equal ''

  it "tagsString returns single string for 1 length tags", ->
    m = new M.Employee tags: [{name:'backbone'}]
    expect( m.tagsString() ).to.equal 'backbone'

  it "tagsString returns and separated string for 1 length tags", ->
    m = new M.Employee tags: [{name:'backbone'},{name:'underscore'}]
    expect( m.tagsString() ).to.equal 'backbone & underscore'

  it "tagsString returns commma and and separated string for 1 length tags", ->
    m = new M.Employee tags: [{name:'backbone'},{name:'underscore'},{name:'node'}]
    expect( m.tagsString() ).to.equal 'backbone, underscore & node'

  it "tagsString returns commma and and separated string for 1 length tags", ->
    m = new M.Employee tags: [{name:'backbone'},{name:'underscore'},{name:'node'},{name:'mongo'}]
    expect( m.tagsString() ).to.equal 'backbone, underscore, node & mongo'