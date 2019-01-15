
// Settings
const port = 1337;

// Dependencies
const Gun  = require('gun');
const http = require('http');

// Initialize the server
const server = http.createServer(Gun.serve());

// Start listening
server.listen(port, function() {
  console.log('Now listening on', port);
});
