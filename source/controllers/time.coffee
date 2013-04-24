class TimeCtrl extends Monocle.Controller

  elements:
    "header .title > strong"  : "title"
    "[data-like=stop] span"   : "like"

  events:
    "tap [data-like=stop]"    : "onLike"

  fetch: (@linestop) ->
    do Lungo.Notification.show

    storage = Device.Storage.local App.key()
    @liked storage.stops[@linestop.id]

    App.api("GET", "GetPasoParada", codparada: @linestop.id).then (error, result) ->
      unless error
        for time in result
          obj =
            line: time.Linea
            name: time.Ruta
            minutes: time.Tiempos[0].minutos
            meters: time.Tiempos[0].metros
            type: time.Tiempos[0].tipo

          new __View.TimeListItem model: obj

        Lungo.Router.section "time"

      do Lungo.Notification.hide


    @title.html @linestop.name

  onLike: (event) =>
    storage = Device.Storage.local App.key()
    if @like.hasClass "star"
      delete storage.stops[@linestop.id]
      @liked false
    else
      storage.stops[@linestop.id] = @linestop.attributes()
      @liked true

    console.error storage.stops
    Device.Storage.local App.key(), storage

  liked: (like) =>
    if like
      @like.addClass("star").removeClass("star-empty")
    else
      @like.removeClass("star").addClass("star-empty")

__Controller.Time = new TimeCtrl "section#time"
