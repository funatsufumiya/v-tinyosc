module main

import net
import tinyosc

fn main() {
	raddr := "127.0.0.1:9000"
	mut sender := net.dial_udp(raddr)!
	println("OSC send to ${raddr}")

	mut buffer := []u8{cap: 2048}

	v := f32(4.3 + 1.1)
	len := C.tosc_writeMessage(buffer.data, sizeof(buffer), c"/hello", c"fif", 1.0, 2, v)
	C.tosc_printOscBuffer(buffer.data, len);

	sender.write_ptr(buffer.data, int(len))!
}