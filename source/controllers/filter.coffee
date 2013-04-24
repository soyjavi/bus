class FilterCtrl extends Monocle.Controller

  elements:
    "article#locations ul"              : "locations"

  events:
    "tap nav[data-article=locations] a" : "onFilter"

  constructor: ->
    super
    __Model.Location.fetch().then (error, result) =>
      @renderLocations()
      Lungo.Aside.toggle()

  onFilter: (event) ->
    el = Monocle.Dom(event.currentTarget)
    @renderLocations el.data("group")
    el.addClass("active").siblings().removeClass("active")

  renderLocations: (group="99") ->
    @locations.html ""
    for location in __Model.Location.filter group
      new __View.LocationListItem model: location

__Controller.Filter = new FilterCtrl "section#main"
