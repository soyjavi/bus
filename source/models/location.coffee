class __Model.Location extends Monocle.Model

  @fields "id", "name", "description", "type"

  @fetch: ->
    do @destroyAll

    do Lungo.Notification.show
    App.api("GET", "Consultar_FamiliasCentros").then (error, result) ->
      unless error
        for group in result
          for location in group.Registros
            __Model.Location.create
              id: location.CodigoElemento
              name: location.DescripcionElemento.toLowerCase()
              description: group.DescripcionGrupo
              type: group.CodigoGrupo

        console.error __Model.Location.all()
        do Lungo.Notification.hide

      else

