class __Model.Location extends Monocle.Model

  @fields "id", "name", "description", "type"

  @filter: (value) -> @select (location) -> location.type is value.toString()

  @fetch: ->
    promise = new Hope.Promise()

    do @destroyAll
    do Lungo.Notification.show
    App.api("GET", "Consultar_FamiliasCentros").then (error, groups) =>
      unless error
        for group in groups
          for location in group.Registros
            #Parse
            id = location.CodigoElemento
            id = "0" + id  while id.length < 3
            name = location.DescripcionElemento
            name = name.charAt(0) + name.slice(1).toLowerCase()
            #Model
            __Model.Location.create
              id: id
              name: name
              description: group.DescripcionGrupo
              type: group.CodigoGrupo

        do Lungo.Notification.hide

        promise.done null, @all()

      else
        promise.done error, null

    promise
