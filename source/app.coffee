window.App = do (lng = Lungo) ->

  KEY       = "bizkaibus-likes"
  SERVICE   = "http://openbizkaibus.appspot.com/api/"

  api = (type, method, parameters = {}) ->
    promise = new Hope.Promise()


    # console.error $
    # $$.jsonp
    #   url: SERVICE + method
    #   type: type
    #   data: parameters
    #   dataType: 'json'
    #   async: true
    #   success: (response) =>
    #     promise.done null, response
    #   error: (type, xhr, request) =>
    #     promise.done xhr, null

    $$.ajax
      url: SERVICE + method
      type: type
      data: parameters
      dataType: 'json'
      success: (response) =>
        promise.done null, response
      error: (type, xhr, request) =>
        promise.done xhr, null
    promise


  session = (data) ->
    if data
      __Model.Session.create data
      if data.location
        __Controller.Main.fetch()
      else
        setTimeout App.gps, 400
    else
      __Model.Session.instance()


  gps = ->
    Lungo.Notification.confirm
      icon: "globe"
      title: "Share your location"
      description: "To have a satisfactory experience we need to know where you are."
      accept:
        label: "Accept"
        callback: ->
          setTimeout Lungo.Notification.show, 400
          Device.Gps.get ((position) ->
            App.api("POST", "user/location", position).then (error, result) ->
              session = __Model.Session.instance()
              session.updateAttributes location: result
              __Controller.Main.fetch()
          ),
          ((error) -> console.error "GPS.error", error ),
            options: 1
      cancel:
        label: "Cancel"


  timeSince = (date) ->
    # Parse date
    stamp = date.split(/[ :-]/)
    stamp = new Date(stamp[0],stamp[1]-1, stamp[2], stamp[3], stamp[4], stamp[5])
    seconds = Math.floor((new Date() - stamp) / 1000)

    interval = Math.floor(seconds / 31536000)
    return interval + " years"  if interval > 1

    interval = Math.floor(seconds / 2592000)
    return interval + " months"  if interval > 1

    interval = Math.floor(seconds / 86400)
    return interval + " days"  if interval > 1

    interval = Math.floor(seconds / 3600)
    return interval + " hours"  if interval > 1

    interval = Math.floor(seconds / 60)
    return interval + " minutes"  if interval > 1

    Math.floor(seconds) + " seconds"


  api             : api
  gps             : gps
  session         : session
  timeSince       : timeSince
  key             : -> KEY
