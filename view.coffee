class dropview
    functions_toselect: [
        [".startOfLine",  0, []],
        [".endOfLine",    0, []],
        [".beginCapture", 0, []],
        [".endCapture",   0, []],
        [".then",         1, ["any"]],
        [".multiple",     1, ["*,+,number"]],
    ]
    constructor: (refs, model)->
        @model         = model
        @$verexinput   = $("#verextext")
        @$dropbox      = $(".dropbox")
        @$regexp       = $("#regexp")
        @$verexpeval   = $("#verexeval")
        @$selectionbox = $("#selectionbox")

        @$dropbox.droppable {
            accept: ".draggable",
            drop: (event, ui) ->
                model.updatedropbox(event, ui)
        }

        $verexinput = @$verexinput
        @$verexpeval.click ()->
            model.updateregexp $verexinput.val()

        @initselections()
        @initcallbacks()

    initcallbacks: ()->
        ## set callback
        @model.ondropboxchange @dropinto,   @
        @model.ondropboxchange @addinput,   @
        @model.onregexpchange  @showregexp, @
        
    initselections: ()->
        console.log @functions_toselect
        for [selection, args, defaultval] in @functions_toselect
            $eachselection = $('<div class="method draggable">')

            $eachselectioncontent = $("<p>#{selection}(</p>")
            for arg in [0...args]
                $input = $('<input type="text" />')
                if defaultval[arg]?
                    $input.val defaultval[arg]
                    $input.addClass "defaultval"
                    $input.one 'focus', ()->
                        $(this).val ''
                        $(this).removeClass "defaultval"
                $eachselectioncontent.append $input
            
                
            $eachselectioncontent.append ")"
            $eachselection.append $eachselectioncontent

            $eachselection.bind "content", ()->
                args = ""
                $(this).find("input").each ()->
                    args += ('\"' + $(this).val() + '\"' + ",")
                    
                args = args.slice(0,-1)
                
                $(this).attr "content", ($(this).text().slice(0, -1) + args + ")")
            
            @$selectionbox.append $eachselection

        @$draggables = $(".draggable")
        @$draggables.draggable {
            start: ()->
                console.log $(this).find("p").text()
                console.log $(this).trigger "content"
                console.log $(this).attr "content"
            helper: "clone",
            appendTo: "body",
        }

    addinput: ($obj, context)->
        content = context.model.extractcontent $obj
        context.$verexinput.val context.$verexinput.val()+content
        context.model.updateregexp context.$verexinput.val()
    dropinto: ($obj, context)->
        context.$dropbox.append $obj
    showregexp: (regexp, context)->
        context.$regexp.text regexp