help:
	@echo "help\n" \
		"make keyboard/layout"

%/build:
	$(eval keyboard := $(firstword $(subst /, ,$*)))
	$(eval keymap := $(word 2, $(subst /, ,$*)))
	docker run --rm \
		-e KEYBOARD=$(keyboard) \
		-e KEYMAP=$(keymap) \
		-v $(shell pwd)/keyboards/$(keyboard)/keymaps/$(keymap):/qmk_firmware/keyboards/$(keyboard)/keymaps/$(keymap):ro \
		-v $(shell pwd)/.build:/qmk_firmware/.build:rw \
		edasque/qmk_firmware
%/send:
	$(eval keyboard := $(firstword $(subst /, ,$*)))
	$(eval keymap := $(word 2, $(subst /, ,$*)))
	docker run --rm -it \
		-e hex=$(keyboard)_$(keymap) \
		-v $(shell pwd)/.build:/qmk/.build:ro \
		--privileged \
		minodisk/teensy_loader:0.0.1

.PHONY: ergodox_ez/*
ergodox_ez/default:     ergodox_ez/default/build
ergodox_ez/default_osx: ergodox_ez/os_x/build
ergodox_ez/my_layout:   ergodox_ez/my_layout/build