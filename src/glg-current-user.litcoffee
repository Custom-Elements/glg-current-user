# glg-current-user
Fetches data all about the current user.

## Dependencies

    Cookies = require 'cookies-js'
    QueryString = require 'query-string'

    Polymer 'glg-current-user',

##Attributes

## Events

## Methods
###getCurrentUser
Fetch full details for the current user by reading the auth cookie, and fetching them from the database.

      getCurrentUser: ->
        # parse our the glgroot cookies, which is itself a querystring
        userParams = if (Cookies.get 'glgroot')? then QueryString.parse Cookies.get 'glgroot' else Cookies.get 'starphleet_user'
        # another cookie, found in Vega manage members
        if not userParams
          userParams = Cookies.get 'glgSAM'
        if userParams
          if userParams['username']?
            bits = userParams['username'].split '\\'
            @username = if bits.length is 2 then bits[1] else bits[0]
          else
            @username = userParams


## Polymer Lifecycle
Fetch the current user by reading the auth cookie, then doing the full lookup.

      attached: ->
        if window.debugUserName
          @username = window.debugUserName
        else
          @getCurrentUser()
