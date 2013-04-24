class __View.LineListItem extends Monocle.View

  container: "section#location article ul"

  template: """
    <li class="selectable arrow">
      <strong>{{id}}</strong>
      <small>{{name}}</small>
    </li>
  """

  events:
    "tap li": "onTap"

  constructor: ->
    super
    @append @model

  onTap: -> __Controller.Line.fetch @model
