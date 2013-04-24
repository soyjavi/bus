class __View.FavoriteLine extends Monocle.View

  container: "aside#menu #favorite-lines ul"

  template: """
    <li>
        <strong class="tag">{{id}}</strong>
        <small>{{name}}</small>
    </li>
  """

  events:
    "tap li": "onTap"

  constructor: ->
    super
    @append @model
    __Model.FavoriteLine.bind "destroy", @bindDelete

  onTap: ->
    __Controller.Line.fetch @model

  bindDelete: (instance) => if instance.uid is @model.uid then @destroy()
