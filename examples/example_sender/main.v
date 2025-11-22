module main

import tinyosc

fn main() {
	mut buffer := []u8{cap: 2048}

	len := C.tosc_writeMessage(buffer.data, sizeof(buffer), c"/hello", c"fi", 1.0, 2)
	// len := C.tosc_writeMessage(buffer.data, sizeof(buffer), c"/hello", c"")
	C.tosc_printOscBuffer(buffer.data, len);
}