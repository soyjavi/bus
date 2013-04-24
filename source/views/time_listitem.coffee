class __View.TimeListItem extends Monocle.View

  container: "section#time article ul"

  template: """
    <li>
      <strong>{{line}}</strong>
      <span class="right tag">{{minutes}} m</span>
      <small>{{name}} - {{type}}</small>
    </li>
  """

  constructor: ->
    super
    @append @model
