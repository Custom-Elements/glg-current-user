# glg-current-user

Renders the body content if, and only if, there is a current authenticated user present. The current user is
exposed to the context, and has the following properties:

  * firstName
  * middleInitial
  * lastName
  * loginName
  * email
  * personId
  * title
  * phoneMain
  * extension
  * fax
  * street1
  * street2
  * city
  * state
  * zip
  * userId (number)
  * personId (number)
  * phone
  * mobile

## Dependencies

    Cookies = require 'cookies-js'
    QueryString = require 'query-string'

Create our element...

    Polymer 'glg-current-user',

## Events
*TODO* describe the custom event `name` and `detail` that are fired.

## Attributes and Change Handlers

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
        self = this
        request.onload = (e) ->
          results = JSON.parse(this.responseText)
          self.currentUser = results[0] if results.length > 0
          console.log "Successfully fetched user"
          console.log self.currentUser

        # make the request
        request.open("GET", "https://epiquery.glgroup.com/glgCurrentUser/getUserByLogin.mustache?login=#{username}", true)
        request.send()

## Event Handlers

## Polymer Lifecycle

      ready: ->

We want to essentially use the body of our glg-current-user element as a template with access to the current
user and its properties. Normally we can't do this, but if we dynamically create our template, we are using the
content of the light DOM to build up shadow DOM elements. The content template is used via ref tag to render
dynamically. Note that we have to do this first, before setting `currentUser`.

        contentTemplate = document.createElement 'template'
        contentTemplate.id = 'content'
        contentTemplate.innerHTML = @innerHTML
        @shadowRoot.appendChild contentTemplate

Fetch the current user by reading the auth cookie, then doing the full lookup.

        @getCurrentUser()
