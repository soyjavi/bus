class FilterCtrl extends Monocle.Controller

  elements:
    "article#locations ul"              : "locations"

  events:
    "tap nav[data-article=locations] a" : "onFilter"

  constructor: ->
    super
    __Model.Location.fetch().then (error, result) =>
      @render()
      Lungo.Aside.toggle()

  onFilter: (event) ->
    el = Monocle.Dom(event.currentTarget)
    @render el.data("group")
    el.addClass("active").siblings().removeClass("active")

  render: (group="99") ->
    @locations.html ""
    for location in __Model.Location.filter group
      new __View.Location model: location

__Controller.Filter = new FilterCtrl "section#main"
