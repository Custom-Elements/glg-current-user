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

Create our element...

    Polymer 'glg-current-user',

## Events
*TODO* describe the custom event `name` and `detail` that are fired.

## Attributes and Change Handlers

## Methods

      getCurrentUser: ->
        self = this
        request = new XMLHttpRequest()
        request.onload = (e) ->
          results = JSON.parse(this.responseText)
          self.currentUser = results[0] if results.length > 0
          console.log self.currentUser

        # todo read from cookie
        login = "glgroup%5Cdfields"

        request.open("GET", "https://epiquery.glgroup.com/glgCurrentUser/getUserByLogin.mustache?login=#{login}", true)
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
