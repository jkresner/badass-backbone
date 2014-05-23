ModelSaveView = require './ModelSaveView'

"""
 A view that has a bunch of tricks
"""
module.exports = class EnhancedFormView extends ModelSaveView

  enableCharCount: (attr) ->
    elm = @elm(attr)
    elm.parent().find('.charCount').html "#{elm.val().length} chars"
    elm.on 'input', =>
      elm.parent().find('.charCount').html "#{elm.val().length} chars"