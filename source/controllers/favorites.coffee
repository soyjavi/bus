class FavoritesCtrl extends Monocle.Controller

  constructor: ->
    super
    storage = Device.Storage.local App.key()
    Device.Storage.local App.key(), {lines: {}, stops: {}} unless storage



__Controller.Mian = new FavoritesCtrl "body"
