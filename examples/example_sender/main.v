module main

import tinyosc

fn main() {
	mut buffer := []u8{cap: 2048}

	v := f32(4.3 + 1.1)
	len := C.tosc_writeMessage(buffer.data, sizeof(buffer), c"/hello", c"fif", 1.0, 2, v)
	// len := tinyosc.tosc_write_message(buffer.data, sizeof(buffer), c"/hello", c"ifif", 5, 2.0, 4, 2.0)
	// len := C.tosc_writeMessage(buffer.data, sizeof(buffer), c"/hello", c"")
	C.tosc_printOscBuffer(buffer.data, len);
}