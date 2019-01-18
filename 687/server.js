
// Settings
const port = 1332;

// Dependencies
const Gun  = require('gun');
const http = require('http');

// Start http server
const server = http.createServer(Gun.serve( __dirname + '/public' )).listen(port, '0.0.0.0', function(err) {
  if (err) throw err;
  console.log('Now listening on', port);
});

// Start gun
let gun = Gun({
  web          : server,
  ws           : {server},
  radisk       : true,
  localStorage : false,
  super        : true,
});
