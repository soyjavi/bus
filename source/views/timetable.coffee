class __View.TimeTable extends Monocle.View

  container: "section#time article ul"

  template: """
    {{#items}}
    <li class="{{#favorite}}accept{{/favorite}}">
      <span class="right tag"><span class="icon time"></span>{{minutes}} m</span>
      <strong>{{line}}</strong>
      <small>{{name}}</small>
    </li>
    {{/items}}
  """

  constructor: ->
    super

    @model.items = @model.items.sort (a, b) ->
     if parseInt(a.minutes) >= parseInt(b.minutes) then 1 else -1

    @html @model
