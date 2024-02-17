import Litedom from 'litedom';
import axios from 'axios';
import { io } from 'socket.io-client';
import './style.less';

const shared = {
  domain: `http://${location.hostname}`,
}

export function getUrlParams () {
  let list, params;

  params = location.search;
  if (params [0] === '?') { params = params.substring (1); }
  list = params.split ('&');
  params = {};
  list.forEach ((item) => {
    item = item.trim ();
    if (item) {
      let parts;
      parts = item.split ('=');
      params [parts [0].trim ()] = parts [1].trim ();
    }
  });
  if (params.domain) { shared.domain = `http://${params.domain}`; }
  shared.params = params;
}

getUrlParams ();
console.log ('domain:', shared.domain);

export const HTML_TEMPLATE = `
<div>
  <div>
    <h1>OS Dev</h1>
    <span>A sandbox for working on an OS.</span>
  </div>
  <button id="bob" style="display: none">start</button>
  <div id="screen_container" class="viewarea">
    <div class="viewarea-text"></div>
    <canvas class="viewarea-canvas"></canvas>
  </div>
</div>
`;

export async function start () {
  Litedom({
    tagName: 'hello-world',
    template: HTML_TEMPLATE,
  });

  let dom;
  dom = document.createElement ('hello-world');
  dom.setAttribute ('name', 'bob');
  document.body.appendChild (dom);

  socket = io (`${shared.domain}:9501`);
  socket.on ('hello', (arg) => {
    // console.log (arg);
    loadEmulator ();
  });
  socket.on ('reload', (arg) => {
    console.clear ();
    location.reload ();
  });
  socket.on ('watcher/asm/error', (arg) => {
    console.error ('- ERROR:', arg);
  });
  // socket.on ('watcher/asm/restarted', (arg) => {
  //   // setTimeout (() => {
  //   //  console.error ('There seems to have been an error reloading asm boot changes. Page did not refresh');
  //   // }, 1000);
  // });
  socket.emit ('howdy', 'stranger');

  let reply;

  reply = await axios.get (`${shared.domain}:9501/status`);
  console.log (reply.data);

  // reply = await axios.get (`${shared.domain}:9501/build`);
  // console.log (reply.data);
  // loadEmulator ();
}

export function loadEmulator () {
  let dom;
  dom = document.querySelector ('#v86');
  if (!dom) {
    dom = document.createElement ('script');
    dom.src = `${shared.domain}:9502/build/libv86.js`;
    dom.id = 'v86';
    dom.onload = () => {
      let button;
      button = document.querySelector ('#bob');
      //button.addEventListener ('click', () => {
        let emulator;
        try {
          button.classList.add ('hide');
          emulator = new V86Starter ({
            screen_container: document.querySelector ('#screen_container'),
            bios: {
              url: `${shared.domain}:9502/bios/seabios.bin`,
              // url: "../../bios/seabios.bin",
            },
            vga_bios: {
              url: `${shared.domain}:9502/bios/vgabios.bin`,
              // url: "../../bios/vgabios.bin",
            },
            // hda: {
            //   url: `${shared.domain}:9502/build/sandbox/hello.bin`,
            //   // url: "../build/sandbox/hello.bin",
            // },
            hda: {
              // url: `${shared.domain}:9502/build/boot.bin`,
              url: `${shared.domain}:9502/build/OS.bin`,
              // url: `${shared.domain}:9502/build/os.img`,
              // url: `${shared.domain}:9502/build/sandbox/boot.img`,
              // url: `${shared.domain}:9502/build/sandbox/hello.bin`,
              // url: "../build/sandbox/hello.bin",
              // size: 8 * 1024 * 1024 * 1024,
              size: 8 * 1024 * 1024 * 1024,
              async: true,
            },
            // cdrom: {
            //     url: "../../images/linux.iso",
            // },
            autostart: true,
          });
        } catch (err) {
          console.error (err);
        }
      //});
    }
    document.body.appendChild (dom);
  }
}

start ();


/*
export function start () {
  let dom;
  dom = document.createElement ('script');
  dom.src = '/build/libv86.js';
  dom.onload = () => {
    let button;
    button = document.querySelector ('#bob');
    button.addEventListener ('click', () => {
      let emulator;
      button.style.display = 'none';
      emulator = new V86Starter ({
        screen_container: document.getElementById ("screen_container"),
        bios: {
          url: "../../bios/seabios.bin",
        },
        vga_bios: {
          url: "../../bios/vgabios.bin",
        },
        fda: {
          url: "../build/sandbox/hello.bin",
        },
        // cdrom: {
        //     url: "../../images/linux.iso",
        // },
        autostart: true,
      });
    });
  }
  document.body.appendChild (dom);
}

start ();
*/

// ----------------------------------------------


  /*
  document.querySelector ('#bob').addEventListener ('click', () => {
  // window.addEventListener ('load', () => {
    console.log ('- starting...');

    var emulator = new V86Starter({
      screen_container: document.getElementById("screen_container"),
      bios: {
        url: "../../bios/seabios.bin",
      },
      vga_bios: {
        url: "../../bios/vgabios.bin",
      },
      fda: {
        url: "../build/sandbox/hello.bin",
      },
      // cdrom: {
      //     url: "../../images/linux.iso",
      // },
      autostart: true,
    });
  })
  */

// import * as bob from 'https://cdn.jsdelivr.net/npm/ass-js@2.1.1/lib/index.min.js';
// import { X64 } from 'ass-js';
//import '/build/defasm.js';

//export function start () {
//  // console.log ('start', window.defasm);
///*
//  let state = new defasm.AssemblyState();
//  state.compile (`
//;
//; A minimal boot sector that prints a 'Hello, world' message
//;
//
//; Initialize the stack pointer to the address 0x8000
//mov bp, 0x8000
//mov sp, bp
//
//; Our boot sector has been loaded into memory at 0x7c00
//; Set our es segment register to 0x07c0
//; the address to print is calculated (segment * 16 + offset)
//mov ax, 0x07c0
//mov es, ax
//
//; Call BIOS service to print a string
//mov bp, hello
//mov ah, 0x13        ; BIOS function 13 - print a string to the screen
//mov al, 0x01        ; argument, update cursor after printing
//mov bl, 0x0b        ; argument, text color - magenta
//mov cx, 12          ; argument, length of string (including the null terminator)
//mov dh, 2           ; argument, row to put string
//mov dl, 0           ; argument, column to put string
//int 10h             ; call BIOS service
//
//; Loop until the end of time
//jmp $
//
//hello db 'Hello World'
//
//; Padding and magic BIOS number
//times 510-($-$$) db 0
//dw 0xaa55
//
//; So far we've filled 512 bytes. Fill more until we have an entire floppy-size worth's.
//times (163840-512) db 0
//  `);
//
//  // console.log (state.head.dump ()); // <Buffer 90>
//
//  state.compile (`
//[bits 16]
//[org 0x7c00]
//
//; where to load the kernel to
//; KERNEL_OFFSET equ 0x1000
//; mov $4, %ax
//  `);
//  console.log (state.head.dump()); // <Buffer 90 66 b8 04 00>
//*/
//
//  let state = new defasm.AssemblyState();
//  // state.compile ([
//  //   "hello db 'Hello world!',24h",
//  //   // 'mov $4, %ax',
//  //   '',
//  // ].join ('\n'));
//  state.compile (`
//  format ELF executable 3
//  entry start
//
//  ;================== code =====================
//  segment readable executable
//  ;=============================================
//
//  start:
//
//          mov     eax,4             ; System call 'write'
//          mov     ebx,1             ; 'stdout'
//          mov     ecx,msg           ; Address of message
//          mov     edx,msg_size      ; Length  of message
//          int     0x80              ; All system calls are done via this interrupt
//
//          mov     eax,1             ; System call 'exit'
//          xor     ebx,ebx           ; Exitcode: 0 ('xor ebx,ebx' saves time; 'mov ebx, 0' would be slower)
//          int     0x80
//
//  ;================== data =====================
//  segment readable writeable
//  ;=============================================
//
//  msg db 'Hello world!',0xA
//  msg_size = $-msg
//  `);
//  console.log (state.head.dump()); // <Buffer 90 66 b8 04 00>
//
//  // /* Compile just the "nop" instruction */
//  // state.compile('nop');
//  // console.log(state.head.dump()); // <Buffer 90>
//
//  // window.defasm.compile ();
//
//  // const asm = X64();
//  // asm._('mov', ['rax', 0xBABE]);
//
//  // var emulator = new V86Starter({
//  //   screen_container: document.getElementById("screen_container"),
//  //   bios: {
//  //       url: "../../bios/seabios.bin",
//  //   },
//  //   vga_bios: {
//  //       url: "../../bios/vgabios.bin",
//  //   },
//  //   fda: {
//  //     url: "../build/sandbox/hello.bin",
//  //   },
//  //   // cdrom: {
//  //   //     url: "../../images/linux.iso",
//  //   // },
//  //   autostart: true,
//  // });
//}
//
//// window.addEventListener ('load', start);
//start ();
