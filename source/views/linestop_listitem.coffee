class __View.LineStopListItem extends Monocle.View

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

  onTap: -> __Controller.Time.fetch @model
