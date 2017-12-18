var http = require('http');
var fs = require('fs');

var server = http.createServer(function(req, res) {
  res.setHeader('Access-Control-Allow-Origin', `*`);
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST');
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

  var body = '';
  
  req.on('data', function(data) {
    body += data;
  });

  req.on('end', function() {
    fs.writeFile('../src/map.coffee', body, function(err) {
      if (err)
        throw err;

      console.log('wrote to map.coffee');

      res.end('wrote to map.coffee');
    });
  });
});

server.listen(1488);

console.log('map editor saver started');