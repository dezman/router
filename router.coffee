class Router
  constructor: (container) ->
    @container = container
    return this

  start: ->
    @bindUrlChanges()
    route = @getCurrentRoute()
    @goToRoute(route, false)

  goToRoute: (route, pushState = true) ->
    @container.innerHTML = ""
    route = Routes.defaultRoute if Object.keys(Routes.list()).indexOf(route) == -1
    Routes.list()[route]()

    if pushState
      window.history.pushState(null, null, route)
    else
      window.history.replaceState(null, null, route)

  getCurrentRoute: ->
    window.location.pathname

  bindUrlChanges: ->
    window.onpopstate = =>
      @goToRoute(@getCurrentRoute(), false)
