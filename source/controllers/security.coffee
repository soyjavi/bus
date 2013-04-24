class SecurityCtrl extends Monocle.Controller

  STORAGE = "konnes-credentials"

  elements:
    "#nickname"                 : "nickname"
    "#mail"                     : "mail"
    "#password"                 : "password"
    "[data-role=signup]"        : "signup"
    "[data-role=login]"         : "login"
    ".form"                     : "form"

  events:
    "tap [data-action=login]"   : "onLogin"
    "tap [data-action=signup]"  : "onSignup"
    "tap [data-context=login]"  : "viewLogin"
    "tap [data-context=signup]" : "viewSignup"

  constructor: ->
    super
    @init = _init


  _init = ->
    __Model.Session.destroyAll()
    @login.hide()
    @form.hide()

    storage = Device.Storage.local App.key()
    if storage
      @_request "login", storage
    else
      @form.show()


  onLogin: (event) ->
    credentials =
      mail    : @mail.val()
      password: @password.val()

    if credentials.mail and credentials.password
      @_request "login", credentials
    else
      @_error()


  onSignup: (event) ->
    credentials =
      nickname  : @nickname.val()
      mail      : @mail.val()
      password  : @password.val()

    if credentials.mail and credentials.password and credentials.nickname
      @_request "signup", credentials
    else
      @_error()


  _request: (method, credentials) ->
    Lungo.Notification.show()
    App.api("POST", method, credentials).then (error, result) =>
      if error
        Lungo.Notification.error "Incorrect credentials",
            "To access you need to fill correctly all the fields on the form.",
            "warning-sign"
        @viewLogin()
      else
        Device.Storage.local App.key(), credentials
        App.session result


  _error: ->
    Lungo.Notification.error "Please fill all fields",
        "To access you need to fill correctly all the fields on the form.",
        "warning-sign",
        5


  viewSignup: =>
    @form.show()
    @signup.show()
    @login.hide()


  viewLogin: =>
    @form.show()
    @login.show()
    @signup.hide()


# Lungo.ready ->
#   __Controller.Security = new SecurityCtrl "section#security"
#   do __Controller.Security.init
