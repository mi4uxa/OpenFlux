package main

import "C"
import (
	.os"
)

//export RunMainClient
func RunMainClient(cUrl *C.char) {
	url := C.GoString(cUrl)
	os.Args = []string{
		build_tool",
		--client",
		--transport", "yandex",
		--url", url,
		--socks5", "127.0.0.1:1080",
		--debug",
	}
	main()
}

//export RunMain
func RunMain() {
	main()
}
