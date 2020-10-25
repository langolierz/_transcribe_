# _transcribe_ hardware

this is the hardware section of _transcribe_ - a project created to control panasonic video_mixers with midi.

# BOM

Reference | Qty | Value | source | source-id | section
--- | --- | --- | --- | --- | ---
? | 1|  _transcribe_ pcb | me? or a fab-house | ...  | all
C1 | 1 | 100uf | tayda | [A-1063](https://www.taydaelectronics.com/catalogsearch/result/?q=A-1063) | A 
C2, C3, C4, C5 | 4 | 0.1uf | tayda | [A-4008](https://www.taydaelectronics.com/catalogsearch/result/?q=A-4008) | B
D1, D2 | 2 | 1N4148 | tayda | [A-157](https://www.taydaelectronics.com/catalogsearch/result/?q=A-157) | C
J1 | 1 | europower header (optional) | tayda | [A-2956](https://www.taydaelectronics.com/catalogsearch/result/?q=A-2956) | -
J2, J4, J6 | 3 | AudioJackTSR | tayda | [A-853](https://www.taydaelectronics.com/catalogsearch/result/?q=A-853) | B , C
J3 | 1 | DSUB9 | tayda | [A-300](https://www.taydaelectronics.com/catalogsearch/result/?q=A-300) | B , C
J5, J7 | 2 | DIN-5 | tayda | [A-1010](https://www.taydaelectronics.com/catalogsearch/result/?q=A-1010) | B , C
R1, R2, R3 | 3 |  220 | tayda | [A-2169](https://www.taydaelectronics.com/catalogsearch/result/?q=A-2169)  | C
R4 | 1 | 10k | tayda | [A-2253](https://www.taydaelectronics.com/catalogsearch/result/?q=A-2253)  | C
U1 | 1 | ProMicro5v | [ali](https://www.aliexpress.com/item/1348800135.html) [amazon](https://www.amazon.com/OSOYOO-ATmega32U4-arduino-Leonardo-ATmega328/dp/B012FOV17O/), [sparkfun](https://www.sparkfun.com/products/12640) | - | A
U2 | 1 | MAX232n | tayda | [A-034](https://www.taydaelectronics.com/catalogsearch/result/?q=A-034) | B
U3 | 1 | 6N137 | tayda | [A-871](https://www.taydaelectronics.com/catalogsearch/result/?q=A-871) | C
U4 | 1 | 4069 |  tayda | [A-882](https://www.taydaelectronics.com/catalogsearch/result/?q=A-882) | C
U5 | 1 | usbHostMini | [ali](https://www.aliexpress.com/item/32842815739.html) [amazon](https://www.amazon.com/HiLetgo-Development-Compatible-Interface-Arduino/dp/B01EWW9R1E/) | - | D
U6 | 1 | 78L33 | tayda | [A-492](https://www.taydaelectronics.com/catalogsearch/result/?q=A-492) | D

<details><summary>CORRECTION FOR CIRCUIT V0.2 AND LOWER</summary>

if you have circuit revision 0.2 or lower then there is a mistake on the footprint of the dsub9 connector sorry (serial from the 3.5mm jack to ave55 works fine) follow the following steps to get serial from the dsub9 header on these boards:

- solder the DSUB9_HEADER onto the bottom of the board
- from here pins 2 and 3 need to be swapped
- cut both traces going to dsub (the traces going between and around c2)
- wire the other ends pin13 and pin14 of u2 to the pins on dsub. u2_pin13 to dusb_pion3 and u2_pin14 to dsub_pin2 
- finally due to another error on the board IF you have placed the 3.5mm jack at J2 THEN you must have a stereo cable plugged into this to use the DSUB9 output (otherwise signal is grounded)

![image](https://user-images.githubusercontent.com/12017938/97021555-43dda480-1553-11eb-9862-1321866dfa1b.png)
![image](https://user-images.githubusercontent.com/12017938/97021587-4e983980-1553-11eb-98bb-da4398e9c42a.png)


</details>

## potential additional parts to add : 


## assemble guide :

- i soldered the resistors, capicitors, diodes and regulator first, then the ics(/sockets) and pin headers, then the jacks
- i used pin sockets to attach the pro-micro and usb host to board in detatchable way (helpful for debugging) but this is up to you

blah blah blah

IF USING USB_HOST_MIDI YOU __MUST CUT A TRACE__ ON THE BOARD ! heres how - ...

# explaining the sections of _transcribe_

 _transcribe_ is based around an arduino micro controller. included in this circuit are a number of different ways to input midi and output serial. you can choose which sections to populate based on your personal requirements.

## A - micro-conntroller - centre

this is the brain of the circuit and is __required__ to make it do anything. i am using a sparkfun pro-micro 5v, which uses micro-usb as power. (it is likely this circuit will also work with an arduino nano - which will require a seperate version of the pcb - but watch this space)

## B - rs232 serial - output(/input)

panasonic video mixers (and other older devices) use a different serial standard (RS232) to micro-controllers (ttl). in this section serial commands from the uC are level-shifted to be recongised by these devices. _only obmit this section if you are not interested in controlling old (rs232) gear_. the data is exposed on a 3.5mm TRS (stereo) jack; tip - input, ring - output, sleave - ground.

NOTE - although not used by the default firmware, the hardware also allows rs232 serial input, so this porject could be modified to also control something _from_ old gear

## C - serial midi - input(/output)

the uC (in A) can act as a USB midi _device_. this means it can be controlled by a USB midi _host_ (such as a computer running abeton, or a raspberry pi). this section includes the additional circuity to also control it with serial-midi (often seen on older instruments with din5 type plugs)

NOTE - although din5 plugs are often used for connecting old gear with serial midi, these sockets can be bulky and sometimes difficult to find. for this reason newer gear supporting serial-midi often use TRS jacks - leaving the standard-conversion to cables. i would use 3.5mm TRS (stereo) also for midi in and out, with tip - midi data (din-pin4), ring - midi plus (din-pin5), sleave - unconnected (or include a switch to swap tip/ring...)

NOTE - although not used by the default firmware, the hardware also allows serial-midi output, so this project could be modified to also output serial midi

_obmit this section if you are not interested in interfacing with 'old style' serial midi_

## D USB-midi HOST

the uC (in A) can act as a USB midi _device_. this means it can be controlled by a USB midi _host_ (such as a computer running abeton, or a raspberry pi). this section includes additional circuitry to allow the uC to also act as a USB midi __HOST__. this means it can be controlled by a USB midi _device_ such as a korg nanokontroller (or many other external usb-midi controllers/ gear). _obmit this section if you are not interested in controlling from a usb-midi device_

# section summary

## video-mixer controlling options:

- control rs232-mixer with usb-midi from host : A + B
- control rs232-mixer with serial-midi : A + B + C
- control rs232-mixer with usb-midi from device : A + B + D

## some bonus converting options:

- convert usb-midi controller to serial midi : A + C + D
- convert rs232 commands to serial-midi : A + B + C
- use a ps3 controller to send serial-midi : A + C + D
