$ ()->
  @model = new dropmodel @refs
  @view  = new dropview @refs, @model

  $("section.span12").css {
    "background-color" : "#FEE"
  }
  $(".row").css "height", "400"
  $("#selectionbox").css {
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
    "margin"           : "2%",
    "background-color" : "#EEF"
  }
