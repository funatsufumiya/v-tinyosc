@[translated]
module tinyosc

#flag -I @VMODROOT/c/tinyosc

$if windows {

#flag -lWs2_32

}$else{

}

#include "tinyosc.h"
#include "tinyosc.c"

//* *Copyright (c) 2015-2018, Martin Roth (mhroth@gmail.com)
// * *Permission to use, copy, modify, and/or distribute this software for any
// *purpose with or without fee is hereby granted, provided that the above
// *copyright notice and this permission notice appear in all copies.
// * *THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
// *REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
// *AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
// *INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
// *LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
// *OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
// *PERFORMANCE OF THIS SOFTWARE.
// 
struct Tosc_message { 
	format &i8
// a pointer to the format field
	marker &i8
// the current read head
	buffer &i8
// the original message data (also points to the address)
	len u32
// length of the buffer data
}
struct Tosc_bundle { 
	marker &i8
// the current write head (where the next message will be written)
	buffer &i8
// the original buffer
	bufLen u32
// the byte length of the original buffer
	bundleLen u32
// the byte length of the total bundle
}
//* *Returns true if the buffer refers to a bundle of OSC messages. False otherwise.
// 
fn C.tosc_isBundle(buffer &i8) bool

pub fn tosc_is_bundle(buffer &i8) bool {
	return C.tosc_isBundle(buffer)
}

//* *Reads a buffer containing a bundle of OSC messages.
// 
fn C.tosc_parseBundle(b &Tosc_bundle, buffer &i8, len int)

pub fn tosc_parse_bundle(b &Tosc_bundle, buffer &i8, len int) {
	C.tosc_parseBundle(b, buffer, len)
}

//* *Returns the timetag of an OSC bundle.
// 
fn C.tosc_getTimetag(b &Tosc_bundle) u64

pub fn tosc_get_timetag(b &Tosc_bundle) u64 {
	return C.tosc_getTimetag(b)
}

//* *Parses the next message in a bundle. Returns true if successful.
// *False otherwise.
// 
fn C.tosc_getNextMessage(b &Tosc_bundle, o &Tosc_message) bool

pub fn tosc_get_next_message(b &Tosc_bundle, o &Tosc_message) bool {
	return C.tosc_getNextMessage(b, o)
}

//* *Returns a point to the address block of the OSC buffer.
// *This is also the start of the buffer.
// 
fn C.tosc_getAddress(o &Tosc_message) &i8

pub fn tosc_get_address(o &Tosc_message) &i8 {
	return C.tosc_getAddress(o)
}

//* *Returns a pointer to the format block of the OSC buffer.
// 
fn C.tosc_getFormat(o &Tosc_message) &i8

pub fn tosc_get_format(o &Tosc_message) &i8 {
	return C.tosc_getFormat(o)
}

//* *Returns the length in bytes of this message.
// 
fn C.tosc_getLength(o &Tosc_message) u32

pub fn tosc_get_length(o &Tosc_message) u32 {
	return C.tosc_getLength(o)
}

//* *Returns the next 32-bit int. Does not check buffer bounds.
// 
fn C.tosc_getNextInt32(o &Tosc_message) int

pub fn tosc_get_next_int32(o &Tosc_message) int {
	return C.tosc_getNextInt32(o)
}

//* *Returns the next 64-bit int. Does not check buffer bounds.
// 
fn C.tosc_getNextInt64(o &Tosc_message) i64

pub fn tosc_get_next_int64(o &Tosc_message) i64 {
	return C.tosc_getNextInt64(o)
}

//* *Returns the next 64-bit timetag. Does not check buffer bounds.
// 
fn C.tosc_getNextTimetag(o &Tosc_message) u64

pub fn tosc_get_next_timetag(o &Tosc_message) u64 {
	return C.tosc_getNextTimetag(o)
}

//* *Returns the next 32-bit float. Does not check buffer bounds.
// 
fn C.tosc_getNextFloat(o &Tosc_message) f32

pub fn tosc_get_next_float(o &Tosc_message) f32 {
	return C.tosc_getNextFloat(o)
}

//* *Returns the next 64-bit float. Does not check buffer bounds.
// 
fn C.tosc_getNextDouble(o &Tosc_message) f64

pub fn tosc_get_next_double(o &Tosc_message) f64 {
	return C.tosc_getNextDouble(o)
}

//* *Returns the next string, or NULL if the buffer length is exceeded.
// 
fn C.tosc_getNextString(o &Tosc_message) &i8

pub fn tosc_get_next_string(o &Tosc_message) &i8 {
	return C.tosc_getNextString(o)
}

//* *Points the given buffer pointer to the next blob.
// *The len pointer is set to the length of the blob.
// *Returns NULL and 0 if the OSC buffer bounds are exceeded.
// 
fn C.tosc_getNextBlob(o &Tosc_message, buffer &&u8, len &int)

pub fn tosc_get_next_blob(o &Tosc_message, buffer &&u8, len &int) {
	C.tosc_getNextBlob(o, buffer, len)
}

//* *Returns the next set of midi bytes. Does not check bounds.
// *Bytes from MSB to LSB are: port id, status byte, data1, data2.
// 
fn C.tosc_getNextMidi(o &Tosc_message) &u8

pub fn tosc_get_next_midi(o &Tosc_message) &u8 {
	return C.tosc_getNextMidi(o)
}

//* *Resets the read head to the first element.
// * *@return  The same tosc_message pointer.
// 
fn C.tosc_reset(o &Tosc_message) &Tosc_message

pub fn tosc_reset(o &Tosc_message) &Tosc_message {
	return C.tosc_reset(o)
}

//* *Parse a buffer containing an OSC message.
// *The contents of the buffer are NOT copied.
// *The tosc_message struct only points at relevant parts of the original buffer.
// *Returns 0 if there is no error. An error code (a negative number) otherwise.
// 
fn C.tosc_parseMessage(o &Tosc_message, buffer &i8, len int) int

pub fn tosc_parse_message(o &Tosc_message, buffer &i8, len int) int {
	return C.tosc_parseMessage(o, buffer, len)
}

//* *Starts writing a bundle to the given buffer with length.
// 
fn C.tosc_writeBundle(b &Tosc_bundle, timetag u64, buffer &i8, len int)

pub fn tosc_write_bundle(b &Tosc_bundle, timetag u64, buffer &i8, len int) {
	C.tosc_writeBundle(b, timetag, buffer, len)
}

//* *Write a message to a bundle buffer. Returns the number of bytes written.
// 
@[c2v_variadic]
fn C.tosc_writeNextMessage(b &Tosc_bundle, address &i8, format &i8, ...voidptr) u32

// pub fn tosc_write_next_message(b &Tosc_bundle, address &i8, format &i8, values ...voidptr) u32 {
// 	return C.tosc_writeNextMessage(b, address, format, ...values)
// }

//* *Returns the length in bytes of the bundle.
// 
fn C.tosc_getBundleLength(b &Tosc_bundle) u32

pub fn tosc_get_bundle_length(b &Tosc_bundle) u32 {
	return C.tosc_getBundleLength(b)
}

//* *Writes an OSC packet to a buffer. Returns the total number of bytes written.
// *The entire buffer is cleared before writing.
// 
@[c2v_variadic]
fn C.tosc_writeMessage(buffer &i8, len int, address &i8, fmt &i8, ...voidptr) u32

// pub fn tosc_write_message(buffer &i8, len u32, address &i8, fmt &i8, values ...voidptr) u32 {
// 	return C.tosc_writeMessage(buffer, len, address, fmt, ...values)
// }

//* *A convenience function to (non-destructively) print a buffer containing
// *an OSC message to stdout.
// 
fn C.tosc_printOscBuffer(buffer &i8, len int)

pub fn tosc_print_osc_buffer(buffer &i8, len int) {
	C.tosc_printOscBuffer(buffer, len)
}

//* *A convenience function to (non-destructively) print a pre-parsed OSC message
// *to stdout.
// 
fn C.tosc_printMessage(o &Tosc_message)

pub fn tosc_print_message(o &Tosc_message) {
	C.tosc_printMessage(o)
}

// _TINY_OSC_
