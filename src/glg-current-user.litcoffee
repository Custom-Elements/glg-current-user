# glg-current-user

Renders the body content if, and only if, there is a current authenticated user present. The current user is
exposed to the context.

## Dependencies

    Cookies = require 'cookies-js'
    QueryString = require 'query-string'

Create our element...

    Polymer 'glg-current-user',

## Events
###user
Fire this with the user when fetched. Sometimes you don't want or need to bind.

## Methods

Fetch full details for the current user by reading the auth cookie, and fetching them from the database.

      getCurrentUser: ->

        # parse our the glgroot cookies, which is itself a querystring
        userParams = QueryString.parse Cookies.get 'glgroot'
        username = userParams['username']
        if username
          console.log "Current user appears to be #{username}"
        else
          console.log "No current user found"
          return

        # prepare our request
        request = new XMLHttpRequest()
        request.onload = (e) =>
          results = JSON.parse(request.responseText)
          @currentUser = results[0] if results.length > 0
          console.log "Successfully fetched user", @currentUser
          @fire 'user', @currentUser

        # make the request
        request.open("GET", "https://epiquery.glgroup.com/glgCurrentUser/getUserByLogin.mustache?login=#{username}", true)
        request.send()

## Polymer Lifecycle
Fetch the current user by reading the auth cookie, then doing the full lookup.

      attached: ->
        @getCurrentUser()
