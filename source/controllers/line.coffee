class LineCtrl extends Monocle.Controller

  elements:
    "header .title > strong"    : "title"
    "[data-like=line] span"     : "like"
    "ul"                        : "stops"

  events:
    "tap [data-like=line]" : "onLike"

  constructor: ->
    super

  fetch: (@line) ->
    do Lungo.Notification.show

    storage = Device.Storage.local App.key()
    @liked storage.lines[line.id]
    @stops.html ""
    #@TODO: Hacer optimización
    do __Model.LineStop.destroyAll
    parameters =
      codLinea: line.id
      sentido: "I"

    __Model.LineStop.destroyAll()
    App.api("GET", "ParadasLinea", parameters).then (error, result) =>
      unless error
        for linestop in result
          m = __Model.LineStop.findBy "id", linestop.CodigoLinea
          if m is undefined and linestop.Municipio isnt ""
            m = __Model.LineStop.create
              id: linestop.CodigoLinea
              name: linestop.NombreParada
              location: linestop.Municipio
              latitude: linestop.Latitud
              longitude: linestop.Longitud

            new __View.LineStopListItem model: m

        @title.html @line.id
        Lungo.Router.section "line"

      do Lungo.Notification.hide

  onLike: (event) =>
    storage = Device.Storage.local App.key()
    if @like.hasClass "star"
      delete storage.lines[@line.id]
      @liked false
    else
      storage.lines[@line.id] = @line.attributes()
      @liked true
    Device.Storage.local App.key(), storage

  liked: (like) =>
    if like
      @like.addClass("star").removeClass("star-empty")
    else
      @like.removeClass("star").addClass("star-empty")


__Controller.Line = new LineCtrl "section#line"
