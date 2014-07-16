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
        @username = userParams['username']
        if @username
          console.log "Current user appears to be #{@username}"
        else
          console.log "No current user found"
          return
        @$.userdetails.url="//query.glgroup.com/glgCurrentUser/getUserByLogin.mustache?login=#{@username}&callback="
        @$.userdetails.go()

      getuserdetails: (evt) ->
        @currentuser = evt.detail.response[0]
        @fire 'user', @currentuser
        user=@username.split("\\")[1]
        @$.betalist.url="//kvstore.glgroup.com/kv/__user_betas__/#{user}?callback="
        @$.betalist.go()

      getbetagroups: (evt) ->
        user=@username.split("\\")[1]
        @currentuser.betagroups = evt.detail.response[user]
        @fire 'user', @currentuser

## Polymer Lifecycle
Fetch the current user by reading the auth cookie, then doing the full lookup.

      attached: ->
        @getCurrentUser()
