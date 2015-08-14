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
        # see which cookies exist
        glgroot = Cookies.get 'glgroot'
        starphleet_user = Cookies.get 'starphleet_user'
        glgSAM = Cookies.get 'glgSAM'
        user = Cookies.get 'user'
        loginName = Cookies.get 'loginName'

        # grab the user name from whatever cookie is first available
        @username = switch
          when glgroot?
            userParams = QueryString.parse glgroot
            bits = userParams['username'].split '\\'
            if bits.length is 2 then bits[1] else bits[0]
          when starphleet_user?
            starphleet_user
          when glgSAM?
            glgSAM
          when loginName?
            uname = loginName.match /s:([A-z0-9]+)/
            uname[1]
          else
            null

## Polymer Lifecycle
Fetch the current user by reading the auth cookie, then doing the full lookup.

      attached: ->
        if window.debugUserName
          @username = window.debugUserName
        else
          @getCurrentUser()
