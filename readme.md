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
