class __View.LineStop extends Monocle.View

  container: "section#line article ul"

  template: """
    <li class="selectable arrow">
      <strong>{{name}}</strong>
      <small>{{location}}</small>
    </li>
  """

  events:
    "tap li": "onTap"

  constructor: ->
    super
    @append @model

  onTap: -> __Controller.Stop.fetch @model
