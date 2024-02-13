import { Server } from 'socket.io';

export function start () {
  let port;

  port = 9503;
  const io = new Server (port, {
    origins: '*',
  });

  console.log ('- socket server started:', port);
  io.on ('connection', (socket) => {
    socket.emit ('hello', 'world');
    socket.on ('howdy', (arg) => {
      console.log (arg);
    });
  })
}
