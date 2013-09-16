$(()->
    ## init DOM 
    $verexinput = $("#verextext")
 
    $(".draggable").draggable {
        helper: "clone",
        appendTo: "body",
    }
    $("#test").draggable()

    ## layout
    $("section.span12").css {
        "background-color" : "#FEE"
    }
    $(".row").css "height", "100"
    $("#sub").css {
        "height" : "100%"
    }
    $("#main").css {
        "background-color" : "#EEE",
        "height"           : "100%"
    }

    ## select list
    $(".selectlist").css {
        "background-color" : "#DDD"
    }
    $(".method").css {
        "background-color" : "#EEF"
    }

    ## drag to
    $("*.dropbox").droppable({
        accept: ".draggable",
        over: (event, ui) ->
            #alert "over"
        drop: (event, ui) ->
            console.log ui.draggable
            $verexinput.val( $verexinput.val() + ui.draggable.find("p").text() )
            $(this).append(ui.draggable.clone())
    })

    ## verex
    $verexinput.val("VerEx()")
    $verexinput.eval = ()->
        console.log eval this.val()
        console.log eval "1+1"
    
    $("#verexeval").click ()->
        $verexinput.eval()
        
)