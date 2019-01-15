const Gun  = require('gun');

// Helper function
function timeout( ms, comment ) {
  if (comment) console.log(comment);
  return new Promise( r => setTimeout(r,ms) );
}

// Let's support async stuff
(async () => {

  // Allow the server to start up
  await timeout( 1000, 'Waiting for server startup' );

  // Initialize gun
  const gun  = Gun({
    web          : false,
    radisk       : false,
    localStorage : false,
    file         : false,
    s3           : false,
    super        : false,
    WebSocket    : require('cws'),
    peers        : [
      'ws://localhost:1332'
    ]
  });

  // Allow gun to start up
  await timeout( 1000, 'Waiting for gun startup' );

  // Write the user
  console.log('Writing data');
  gun.get('user').get('admin').put({
    username: 'admin'
  }, function(ack) {
    console.log('ACK:',ack);
  });

  // Let it pass through the whole network
  let timer = 20;
  while(timer) {
    console.log('Passing time to let data flow:', timer--);
    await timeout(1000);
  }

  // Try to print the user
  console.log('Loading...');
  gun.get('user').get('admin').once(function(admin) {
    console.log('Received:', admin);
    process.exit( admin ? 0 : 1 );
  });
})();
