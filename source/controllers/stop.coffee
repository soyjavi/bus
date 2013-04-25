class StopCtrl extends Monocle.Controller

  elements:
    "header .title > strong"  : "title"
    "[data-like=stop] span"   : "like"
    "ul"                      : "times"

  events:
    "tap [data-like=stop]"    : "onLike"

  fetch: (@linestop) ->
    do Lungo.Notification.show

    storage = Device.Storage.local App.key()
    @liked storage.stops[@linestop.id]
    @times.html ""

    do __Model.LineStop.destroyAll
    App.api("GET", "GetPasoParada", codparada: @linestop.id).then (error, result) =>
      unless error
        timetable = []
        for time in result
            timetable.push
              line: time.Linea
              name: time.Ruta
              minutes: time.Tiempos[0].minutos
              meters: time.Tiempos[0].metros
              type: time.Tiempos[0].tipo
              favorite: if storage.lines[time.Linea] then true else false

          new __View.TimeTable model: items: timetable


        position =
          latitude: @linestop.latitude
          longitude: @linestop.longitude

        Lungo.Sugar.GMap.init
          el: ".map"

        Lungo.Sugar.GMap.addMarker position, null, false
        Lungo.Sugar.GMap.center position
        Lungo.Sugar.GMap.zoom 17
        Lungo.Sugar.GMap.clean()

        Lungo.Router.section "time"

      do Lungo.Notification.hide


    @title.html @linestop.name

  onLike: (event) =>
    storage = Device.Storage.local App.key()
    if @like.hasClass "star"
      model = __Model.FavoriteStop.findBy "id", @linestop.id
      if model
        delete storage.stops[@linestop.id]
        model.destroy()
        @liked false
    else
      model = __Model.FavoriteStop.create @linestop.attributes()
      if model
        storage.stops[@linestop.id] = @linestop.attributes()
        @liked true
    Device.Storage.local App.key(), storage

  liked: (like) =>
    if like
      @like.addClass("star").removeClass("star-empty")
    else
      @like.removeClass("star").addClass("star-empty")

__Controller.Stop = new StopCtrl "section#time"

Lungo.ready ->
  # Lungo.Sugar.GMap.init
  #   el: ".map"
  # Lungo.Sugar.GMap.image
  #   el: ".map"

