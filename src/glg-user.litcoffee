# glg-current-user
All about a GLG user.

## Dependencies

    Polymer 'glg-user',

##Attributes
###username
This is who you are. Changing this gets your user data.

      usernameChanged: ->
        if window.glgUserCache[@username]
          @currentuser = window.glgUserCache[@username]
          @fire 'user', @currentuser
        else if @username
          @$.userdetails.url="https://services.glgresearch.com/epiquery/glgCurrentUser/getUserByLogin.mustache?login=#{@domainifyUsername(@username)}&callback="
          @$.userdetails.go()

## Events
###user
Fire this with the user when fetched. Sometimes you don't want or need to bind.

## Methods

      domainifyUsername: (name) ->
        if name.toLowerCase().indexOf('glgroup') is -1
          "glgroup%5c#{name}"
        else
          name

      dedomainifyUsername: (name) ->
        if name.toLowerCase().indexOf('glgroup') is -1
          name
        else
          name.split('\\')[1]

      getuserdetails: (evt) ->
        @currentuser = evt.detail.response[0]
        @fire 'user', @currentuser

## Polymer Lifecycle

      created: ->
        window.glgUserCache = window.glgUserCache or {}
