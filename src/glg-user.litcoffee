# glg-current-user
All about a GLG user.

## Dependencies

    Polymer 'glg-user',

##Attributes
###username
This is who you are. Changing this gets your user data.

      usernameChanged: ->
        if @username
          @$.userdetails.url="https://query.glgroup.com/glgCurrentUser/getUserByLogin.mustache?login=glgroup\\#{@username}&callback="
          @$.userdetails.go()

## Events
###user
Fire this with the user when fetched. Sometimes you don't want or need to bind.

## Methods

      getuserdetails: (evt) ->
        @currentuser = evt.detail.response[0]
        @fire 'user', @currentuser
        user = @username.split("\\")[1]
        @$.betalist.url="https://kvstore.glgroup.com/kv/__user_betas__/#{user}?callback="
        @$.betalist.go()

      getbetagroups: (evt) ->
        @currentuser.betagroups = evt.detail.response[@username]
        @fire 'user', @currentuser

## Polymer Lifecycle
