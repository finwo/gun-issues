const Gun  = require('gun');

// Initialize gun
const gun  = Gun({
  web          : false,
  radisk       : true,
  localStorage : false,
  file         : false,
  s3           : false,
  super        : false,
  // WebSocket    : require('cws'),
  // peers        : [
  //   'ws://localhost:1332'
  // ]
});

// Write the user
console.log('Writing data');
gun.get('user').get('admin').put({
  username: 'admin'
}, function(ack) {
  console.log('ACK:',ack);
});

// Try to print the user
console.log('Loading...');
gun.get('user').get('admin').once(function(admin) {
  console.log('Received:', admin);
  process.exit( admin ? 0 : 1 );
});
