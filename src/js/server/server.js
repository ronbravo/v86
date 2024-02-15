import restana from 'restana';
import cors from 'cors';
import { spawn } from 'child_process';
import { fileURLToPath } from 'url';
import { join } from 'path';
import { Server } from 'socket.io';

const shared = {
}

export function createWatchers (details = {}) {
  let { sockets } = details;

  shared.asmWatcher = spawn (`nodemon --exec "pnpm run build:bin" --watch ./src/asm -e asm`, {
    shell: true,
    stdio: ['pipe', 'pipe', 'pipe', 'ipc'],
  });
  shared.asmWatcher.on('message', function (event) {
    if (event.type === 'start') {
      console.log ('- nodemon: boot assembly file watcher started');
      for (let key in sockets) {
        let socket = sockets [key];
        socket.emit ('watcher/asm/restarted');
      }
    } else if (event.type === 'error') {
      console.log ('- asm watcher had an error.');
    }
  });

  shared.bootWatcher = spawn (`nodemon --exec "echo \"- reloading os\"" --watch ./build -e bin`, {
    shell: true,
    stdio: ['pipe', 'pipe', 'pipe', 'ipc'],
  });
  shared.bootWatcher.on('message', function (event) {
    if (event.type === 'start') {
      console.log ('- nodemon: boot binary watcher started');
      for (let key in sockets) {
        let socket = sockets [key];
        socket.emit ('reload');
      }
    } else if (event.type === 'error') {
      console.log ('- boot binary watcher had an error.');
    }
  });
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
