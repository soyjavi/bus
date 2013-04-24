class LocationCtrl extends Monocle.Controller

  elements:
    "header .title > strong"  : "title"
    "ul"                      : "lines"

  constructor: ->
    super

  fetch: (location) =>
    do Lungo.Notification.show

    @lines.html ""
    #@TODO: Hacer optimización
    do __Model.Line.destroyAll
    App.api("GET", "LineasMunicipio", codmunicipio: location.id).then (error, result) =>
      unless error
        for line in result
          m = __Model.Line.create
            id: line.CodigoLinea
            name: line.DenominacionLinea

          new __View.Line model: m

        @title.html location.name
        Lungo.Router.section "location"
        do Lungo.Notification.hide

__Controller.Location = new LocationCtrl "section#location"
