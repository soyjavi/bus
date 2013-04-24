class FavoritesCtrl extends Monocle.Controller


  constructor: ->
    super
    __Model.FavoriteLine.bind "create", @FavoriteCreated
    __Model.FavoriteStop.bind "create", @FavoriteCreated


    storage = Device.Storage.local App.key()
    Device.Storage.local App.key(), {lines: {}, stops: {}} unless storage
    @fetch storage

  fetch: (storage) ->
    __Model.FavoriteLine.create storage.lines[line] for line of storage.lines
    __Model.FavoriteStop.create storage.stops[stop] for stop of storage.stops

  FavoriteCreated: (model) -> new __View[model.className] model: model

__Controller.Favorites = new FavoritesCtrl "body"
