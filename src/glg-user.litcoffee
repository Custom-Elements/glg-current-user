# glg-current-user
All about a GLG user.

## Dependencies

    Polymer 'glg-user',

##Attributes
###username
This is who you are. Changing this gets your user data.

      usernameChanged: ->
        if @username
          @$.userdetails.url="https://query.glgroup.com/glgCurrentUser/getUserByLogin.mustache?login=#{@domainifyUsername(@username)}&callback="
          @$.userdetails.go()

## Events
###user
Fire this with the user when fetched. Sometimes you don't want or need to bind.

## Methods

      domainifyUsername: (name) ->
        if name.toLowerCase().indexOf('glgroup') is -1
          "glgroup\\#{name}"
        else
          name

      dedomainifyUsername: (name) ->
        if name.toLowerCase().indexOf('glgroup') is -1
          name
        else
          name.split('\\')[1]

      getuserdetails: (evt) ->
        @currentuser = evt.detail.response[0]
        user = @username.split("\\")[1]
        @$.betalist.url="https://kvstore.glgroup.com/kv/__user_betas__/#{@dedomainifyUsername(@username)}"
        @$.betalist.go()

      getbetagroups: (evt) ->
        @currentuser.betagroups = evt.detail.response[@dedomainifyUsername(@username)]
        @fire 'user', @currentuser

## Polymer Lifecycle
