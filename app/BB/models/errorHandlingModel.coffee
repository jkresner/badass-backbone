    #@on 'error', @checkfor500, @



  validateNonEmptyArray: (value, attr, computedState) ->
    # $log 'validateNonEmptyArray', value, attr, computedState
    if !value? || value.length is 0 then true

