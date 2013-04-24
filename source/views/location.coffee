class __View.Location extends Monocle.View

  container: "section#main article#locations ul"

  template: """
    <li class="selectable arrow">
      <strong>{{name}}</strong>
      <!--
      <small>{{description}}</small>
      -->
    </li>
  """

  events:
    "tap li": "onTap"

  constructor: ->
    super
    @append @model

  onTap: -> __Controller.Location.fetch @model
