# 687 Networked NACK on deep put

## Start the example code

```sh
./run.sh
```

## Original issue

First noticed: 0.9.999993
Observed behavior: Missing acknowledgement in the NodeJS console and missing data

Behavior in 0.9.999997: Missing data without warning of any kind.

When I put data on a path which is not known to the super peer, data is not saved over the network. To showcase the issue, I've created some stand-alone code which reproduces the unexpected behavior: [finwo/gun-issues/687](https://github.com/finwo/gun-issues/tree/master/687).

In short, this is broken:

```js
// client.js
// The server simply runs Gun.serve on a bare http server

const Gun = require('gun');
const gun = Gun( 'ws://localhost');

gun.get('user').get('admin').put({
  username: 'admin'
});
```
