class FilterCtrl extends Monocle.Controller

  data = null

  elements:
    "article#locations ul"              : "locations"
    "article#locations input"           : "search"

  events:
    "tap nav[data-article=locations] a" : "onFilter"
    "keyup article#locations input"  : "onSearch"

  constructor: ->
    super
    __Model.Location.fetch().then (error, result) =>
      do @_filter
      do Lungo.Aside.toggle

  onFilter: (event) ->
    el = Monocle.Dom(event.currentTarget)
    el.addClass("active").siblings().removeClass("active")
    @_filter el.data("group")

  onSearch: (event) =>
    value = @search.val().toLowerCase()
    search = @data.filter (item) -> item.name.toLowerCase().indexOf(value) is 0
    @_render search

  _filter: (group="99") ->
    @search.val ""
    @data = __Model.Location.filter group
    @_render @data

  _render: (data) ->
    @locations.html ""
    for location in data
      new __View.Location model: location

__Controller.Filter = new FilterCtrl "section#main"
