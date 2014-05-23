BadassModel = require './BadassModel'

"""
A model that has one or more of it's attributes that is as list
where we can toggle a value in and out of that list
"""
module.exports = class SublistModel extends BadassModel

  toggleAttrSublistElement: (attr, value, compareDelegate) ->

    list = @get(attr)
    if !list?
      @set attr, [value]
    else
      # if it's not yet in the list, add it
      match = _.find list, compareDelegate

      if match?
        @set attr, (_.without list, match)
      else
        @set attr, (_.union list, [value])

    @trigger "change:#{attr}"