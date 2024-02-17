import restana from 'restana';
import cors from 'cors';
import { spawn } from 'child_process';
import { fileURLToPath } from 'url';
import { join } from 'path';
import { Server } from 'socket.io';

import chokidar from 'chokidar';

const shared = {
}

export function createAsmWatcher (details = {}) {
  let { cwd, sockets } = details;

  return function asmWatcher (event, path) {
    let child;
    child = spawn (`make`, {
      cwd,
      shell: true,
    });
    child.stderr.on ('data', (data) => {
      data = data.toString ().trim ();
      console.log ('*** ERROR:', data);
      for (let key in sockets) {
        let socket = sockets [key];
        socket.emit ('watcher/asm/error', data);
      }
    });
    child.on ('exit', (code) => {
      if (code === 0) {
        for (let key in sockets) {
          let socket = sockets [key];
          socket.emit ('reload');
        }
        console.log ('- done building bin file');
      }
    });
  }
}

// export function createBinaryWatcher (details = {}) {
//   let { sockets } = details;

//   return function binaryWatcher (event, path) {
//     // for (let key in sockets) {
//     //   let socket = sockets [key];
//     //   socket.emit ('reload');
//     // }
//     // console.log ('- reload page');
//   }
// }

export function createWatchers (details = {}) {
  let { sockets } = details;
  let cwd;

  cwd = fileURLToPath (import.meta.url);
  cwd = join (cwd, '..', '..', '..', '..', 'src', 'asm');
  shared.asmWatcher = chokidar.watch (cwd).on ('change', createAsmWatcher ({ cwd, sockets }));

  // cwd = fileURLToPath (import.meta.url);
  // cwd = join (cwd, '..', '..', '..', '..', 'build', 'boot.bin');
  // shared.binaryWatcher = chokidar.watch (cwd).on ('add', createBinaryWatcher ({ sockets }));
}

export function start () {
  let app, port;

  port = 9501;

  app = restana ();
  app.use (cors ());

  app.get ('/status', (req, res) => {
    res.send ({ status: 200 });
  });

  console.log ('- api server started:', port);
  app.get ('/build', build);
  app.start (port);

  // Socket
  let io, sockets;
  sockets = {};
  console.log ('- socket server started:', port);
  io = new Server (app.getServer (), {
    cors: {
      origin: '*',
    },
  });
  io.on ('connection', (socket) => {
    socket.emit ('hello', 'world');
    console.log ('- connected:', socket.id);
    sockets [socket.id] = socket;
    socket.on ('howdy', (arg) => {
      console.log (arg);
    });
    socket.on ('disconnect', (reason) => {
      console.log ('- disconnected:', reason, socket.id);
      delete sockets [socket.id];
    });
  });

  // Use Nodemon to watch for bin file changes
  createWatchers ({ sockets });
}

export async function build (req, res) {
  let command, child, file, name, path;

  path = fileURLToPath (import.meta.url);
  path = join (path, '..', '..', '..', '..', 'build', 'sandbox');
  name = 'boot';

  command = ['ls -la'];
  command = ['nasm -f bin ', name, '.asm', ' -o ', name, '.bin'];
  command = command.join ('');

  child = spawn (command, {
    cwd: path,
    shell: true,
    stdio: 'inherit',
  });

//  child.on ('data', (data) => {
//    console.log ('error');
//  });
  child.on ('close', (data) => {
    console.log ('done', command, '\n', path);
    res.send ({
      status: 200,
      command,
      path,
    });
  });
}
