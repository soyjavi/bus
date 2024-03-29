class __View.Favorite extends Monocle.View

  container: "aside#menu #favorite-stops ul"

  template: """
    <li>
        <span class="right tag">{{distance}}s</span>
        <strong>{{name}}</strong>
        <small>{{location}}</small>
    </li>
  """

  events:
    "tap li": "onTap"

  constructor: ->
    super
    @append @model
    __Model.FavoriteStop.bind "destroy", @bindDelete

  onTap: ->
    __Controller.Stop.fetch @model

  bindDelete: (instance) =>
    console.error instance.uid, @model.uid
    if instance.uid is @model.uid then @destroy()
