d = @stubs.dates
@stubs.developers = {}


aDev = (fname, lname, github, so, blog, skills) ->
  firstName:          fname
  lastName:           lname
  githubUrl:          github
  stackoverflowUrl:   so
  blogUrl:            blog
  skills:             skills


@stubs.developers.jsdevs = [
  aDev 'Jonathon', 'Kresner', '/jkresner', '/users/178211/jonathon-kresner', 'http://hackerpreneurialism.com', ['backbone.js','coffeescript','c#','brunch']
  aDev 'John', 'Davison', '/jcdavison', '/users/1345135/john', 'http://www.johncdavison.com/', ['ruby','ruby-on-rails']
]


