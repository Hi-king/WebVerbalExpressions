class dropmodel
    constructor: (refs)->
        @refs = refs
        @ondropboxchange_callbacks = []
        @onregexpchange_callbacks  = []
        
    ondropboxchange: (callback, context)->
        @ondropboxchange_callbacks.push [callback, context]
    onregexpchange:  (callback, context)->
        @onregexpchange_callbacks.push [callback, context]

    extractcontent: ($obj)->
        $obj.trigger "content"
        $obj.attr "content"

    updatedropbox: (event, ui)->
        for [callback, context] in @ondropboxchange_callbacks
            callback(ui.draggable.clone(), context)

    updateregexp: (verbalexp) ->
        regexp = eval "VerEx()"+verbalexp
        for [callback, context] in @onregexpchange_callbacks
            callback(regexp, context)

    