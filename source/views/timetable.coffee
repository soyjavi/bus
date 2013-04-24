class __View.TimeTable extends Monocle.View

  container: "section#time article ul"

  template: """
    {{#items}}
    <li class="{{#favorite}}bck theme{{/favorite}}">
      <strong>{{line}}</strong>
      <span class="right tag">{{minutes}} m</span>
      <small>{{name}} - {{type}}</small>
    </li>
    {{/items}}
  """

  constructor: ->
    super
    @html @model
