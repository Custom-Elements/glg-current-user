# &lt;glg-current-user&gt;

Renders the body content if, and only if, there is a current authenticated user present. The current user is
exposed to the context. Reads the local authentication cookie, and only works internally.

See [src/glg-current-user.litcoffee](src/glg-current-user.litcoffee) for more details.


## Available Properties

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
  * betagroups (array)

### Typical Usage

```html
  <glg-current-user>
    <span>Welcome <b>{{ firstName }}</b> from {{ city }}!</span>
  </glg-current-user>
```

### Usage from Outside

#### `currentuser`

Bind to the `currentuser` attribute of a `glg-current-user`
element to access the current user from outside the element like so:

```html
  <glg-current-user currentuser="{{currentuser}}"></glg-current-user>
```

#### `user` event

Subscribe to the `user` event and read the user off the detail. See demo
for exciting details!

### Debugging

Both `glg-user` and `glg-current-user` have debug properties.

Assign to `window.debugUserName` to force the `glg-current-user` username.
Assign to `window.glgUserCache[USERNAMEHERE]` to force the `glg-user`
`currentuser` property.
