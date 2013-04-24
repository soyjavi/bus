class __Model.LineStop extends Monocle.Model

  @fields "id", "name", "location", "latitude", "longitude"

  @filter: ->
    @

  @sort: ->
    items = __Model.LineStop.all()
    items.sort (a, b) -> items[b] - items[a]
