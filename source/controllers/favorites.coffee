class FavoritesCtrl extends Monocle.Controller

  constructor: ->
    super
    __Model.FavoriteStop.bind "create", @FavoriteCreated
    do @storage

  storage: ->
    storage = Device.Storage.local App.key()
    if storage
      __Model.FavoriteStop.create storage.stops[stop] for stop of storage.stops
    else
      Device.Storage.local App.key(), {lines: {}, stops: {}}

  FavoriteCreated: (model) -> new __View.Favorite model: model

__Controller.Favorites = new FavoritesCtrl "aside"
