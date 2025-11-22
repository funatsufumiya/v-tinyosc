module main

import net
import tinyosc

fn main() {
	raddr := '0.0.0.0:9000'
	mut receiver := net.listen_udp(raddr)!
  defer {
    receiver.close() or { panic(err) }
  }
	println('OSC listening to ${raddr}')

	mut buffer := []u8{len: 2048}
	for {
		len, _ := receiver.read(mut buffer) or { continue }

		if C.tosc_isBundle(buffer.data) {
			bundle := C.tosc_bundle_empty()
			C.tosc_parseBundle(&bundle, buffer.data, len)
			timetag := C.tosc_getTimetag(&bundle)
			osc := C.tosc_message_empty()
			for {
				b := C.tosc_getNextMessage(&bundle, &osc)
				if !b {
					break
				}
				C.tosc_printMessage(&osc)
			}
		} else {
			osc := C.tosc_message_empty()
			C.tosc_parseMessage(&osc, buffer.data, len)
			C.tosc_printMessage(&osc)
		}
	}
}
