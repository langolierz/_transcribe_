EESchema Schematic File Version 4
LIBS:transcribe_circuit-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "_transcribe_"
Date "2020-01-13"
Rev "0.1"
Comp "cyberboy666 & user43368831"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L transcribe_circuit-rescue:ProMicro-promicro U1
U 1 1 5E1CCE60
P 2200 2500
F 0 "U1" H 2200 3537 60  0000 C CNN
F 1 "ProMicro" H 2200 3431 60  0000 C CNN
F 2 "" H 2300 1450 60  0000 C CNN
F 3 "" H 2300 1450 60  0000 C CNN
	1    2200 2500
	1    0    0    -1  
$EndComp
$Comp
L Interface_UART:MAX232 U2
U 1 1 5E1CD5E9
P 5200 3350
F 0 "U2" H 4750 4625 50  0000 C CNN
F 1 "MAX232" H 4850 4525 50  0000 C CNN
F 2 "" H 5250 2300 50  0001 L CNN
F 3 "http://www.ti.com/lit/ds/symlink/max232.pdf" H 5200 3450 50  0001 C CNN
	1    5200 3350
	1    0    0    -1  
$EndComp
$Comp
L transcribe_circuit-rescue:usbHostMini-promicro U4
U 1 1 5E1D17C6
P 2575 6400
F 0 "U4" H 2575 7437 60  0000 C CNN
F 1 "usbHostMini" H 2575 7331 60  0000 C CNN
F 2 "" H 2675 5350 60  0000 C CNN
F 3 "" H 2675 5350 60  0000 C CNN
	1    2575 6400
	1    0    0    -1  
$EndComp
Text Notes 875  950  0    118  ~ 0
micro-controller
Text Notes 4275 975  0    118  ~ 0
rs232 serial
Text Notes 1000 4525 0    118  ~ 0
usb-host shield
Text Notes 7450 1025 0    118  ~ 0
midi serial
$Comp
L Isolator:6N137 U3
U 1 1 5E1E426D
P 9300 2325
F 0 "U3" H 9300 1908 50  0000 C CNN
F 1 "6N137" H 9300 1999 50  0000 C CNN
F 2 "Package_DIP:DIP-8_W7.62mm" H 9100 2025 50  0001 L CIN
F 3 "https://optoelectronics.liteon.com/upload/download/DS70-2008-0032/6N135-L%206N136-L%20series.pdf" H 9300 2325 50  0001 L CNN
	1    9300 2325
	1    0    0    1   
$EndComp
$Comp
L Device:R R1
U 1 1 5E1E86F1
P 8550 2225
F 0 "R1" V 8450 2225 50  0000 C CNN
F 1 "220" V 8550 2225 50  0000 C CNN
F 2 "" V 8480 2225 50  0001 C CNN
F 3 "~" H 8550 2225 50  0001 C CNN
	1    8550 2225
	0    1    1    0   
$EndComp
$Comp
L Device:R R2
U 1 1 5E1E9C5C
P 10050 2125
F 0 "R2" V 9950 2125 50  0000 C CNN
F 1 "10k" V 10050 2125 50  0000 C CNN
F 2 "" V 9980 2125 50  0001 C CNN
F 3 "~" H 10050 2125 50  0001 C CNN
	1    10050 2125
	0    1    1    0   
$EndComp
Text GLabel 10475 2125 2    50   Input ~ 0
MIDI_SERIAL_IN
$Comp
L Device:D D1
U 1 1 5E1EB2E4
P 8800 2375
F 0 "D1" V 8754 2454 50  0000 L CNN
F 1 "1N4148" H 8700 2275 50  0000 L CNN
F 2 "" H 8800 2375 50  0001 C CNN
F 3 "~" H 8800 2375 50  0001 C CNN
	1    8800 2375
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR017
U 1 1 5E1EC60A
P 9800 1750
F 0 "#PWR017" H 9800 1600 50  0001 C CNN
F 1 "+5V" H 9815 1923 50  0000 C CNN
F 2 "" H 9800 1750 50  0001 C CNN
F 3 "" H 9800 1750 50  0001 C CNN
	1    9800 1750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR018
U 1 1 5E1ED3DB
P 9925 2800
F 0 "#PWR018" H 9925 2550 50  0001 C CNN
F 1 "GND" H 9930 2627 50  0000 C CNN
F 2 "" H 9925 2800 50  0001 C CNN
F 3 "" H 9925 2800 50  0001 C CNN
	1    9925 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	9925 2800 9925 2525
Wire Wire Line
	9925 2525 9600 2525
Wire Wire Line
	9600 2125 9800 2125
Wire Wire Line
	10200 2125 10275 2125
Wire Wire Line
	9600 2425 10275 2425
Wire Wire Line
	10275 2425 10275 2125
Connection ~ 10275 2125
Wire Wire Line
	10275 2125 10475 2125
Wire Wire Line
	9800 1750 9800 2125
Connection ~ 9800 2125
Wire Wire Line
	9800 2125 9900 2125
NoConn ~ 9600 2225
Wire Wire Line
	9000 2225 8800 2225
Wire Wire Line
	8800 2225 8700 2225
Connection ~ 8800 2225
Text GLabel 8125 2225 0    50   Input ~ 0
MIDI_IN_PLUS
Text GLabel 8125 2575 0    50   Input ~ 0
MIDI_IN_DATA
Wire Wire Line
	8400 2225 8125 2225
Wire Wire Line
	8800 2525 8800 2575
Wire Wire Line
	8800 2575 8125 2575
$Comp
L Connector:AudioJack3 J2
U 1 1 5E1F0A6D
P 7950 1650
F 0 "J2" H 7932 1975 50  0000 C CNN
F 1 "MIDI_IN" H 7932 1884 50  0000 C CNN
F 2 "" H 7950 1650 50  0001 C CNN
F 3 "~" H 7950 1650 50  0001 C CNN
	1    7950 1650
	1    0    0    -1  
$EndComp
Text GLabel 8300 1650 2    50   Input ~ 0
MIDI_IN_PLUS
Text GLabel 8300 1800 2    50   Input ~ 0
MIDI_IN_DATA
$Comp
L power:GND #PWR015
U 1 1 5E1F3C37
P 8375 1375
F 0 "#PWR015" H 8375 1125 50  0001 C CNN
F 1 "GND" H 8380 1202 50  0000 C CNN
F 2 "" H 8375 1375 50  0001 C CNN
F 3 "" H 8375 1375 50  0001 C CNN
	1    8375 1375
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 1550 8150 1375
Wire Wire Line
	8150 1375 8375 1375
Wire Wire Line
	8150 1650 8300 1650
Wire Wire Line
	8150 1750 8150 1800
Wire Wire Line
	8150 1800 8300 1800
$Comp
L Connector:AudioJack3 J3
U 1 1 5E1F4FCA
P 8025 4200
F 0 "J3" H 8007 4525 50  0000 C CNN
F 1 "MIDI_OUT" H 8007 4434 50  0000 C CNN
F 2 "" H 8025 4200 50  0001 C CNN
F 3 "~" H 8025 4200 50  0001 C CNN
	1    8025 4200
	1    0    0    -1  
$EndComp
Text GLabel 8375 4200 2    50   Input ~ 0
MIDI_OUT_PLUS
Text GLabel 8375 4350 2    50   Input ~ 0
MIDI_OUT_DATA
$Comp
L power:GND #PWR016
U 1 1 5E1F4FD6
P 8450 3925
F 0 "#PWR016" H 8450 3675 50  0001 C CNN
F 1 "GND" H 8455 3752 50  0000 C CNN
F 2 "" H 8450 3925 50  0001 C CNN
F 3 "" H 8450 3925 50  0001 C CNN
	1    8450 3925
	1    0    0    -1  
$EndComp
Wire Wire Line
	8225 4100 8225 3925
Wire Wire Line
	8225 3925 8450 3925
Wire Wire Line
	8225 4200 8375 4200
Wire Wire Line
	8225 4300 8225 4350
Wire Wire Line
	8225 4350 8375 4350
Text GLabel 10425 4425 2    50   Input ~ 0
MIDI_SERIAL_OUT
Text GLabel 9825 4200 0    50   Input ~ 0
MIDI_OUT_PLUS
Text GLabel 9825 4425 0    50   Input ~ 0
MIDI_OUT_DATA
$Comp
L power:+5V #PWR019
U 1 1 5E1F83DF
P 10275 4050
F 0 "#PWR019" H 10275 3900 50  0001 C CNN
F 1 "+5V" H 10290 4223 50  0000 C CNN
F 2 "" H 10275 4050 50  0001 C CNN
F 3 "" H 10275 4050 50  0001 C CNN
	1    10275 4050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5E1F8F29
P 10075 4200
F 0 "R3" V 9975 4200 50  0000 C CNN
F 1 "220" V 10075 4200 50  0000 C CNN
F 2 "" V 10005 4200 50  0001 C CNN
F 3 "~" H 10075 4200 50  0001 C CNN
	1    10075 4200
	0    1    1    0   
$EndComp
$Comp
L Device:R R4
U 1 1 5E1F93F1
P 10075 4425
F 0 "R4" V 9975 4425 50  0000 C CNN
F 1 "220" V 10075 4425 50  0000 C CNN
F 2 "" V 10005 4425 50  0001 C CNN
F 3 "~" H 10075 4425 50  0001 C CNN
	1    10075 4425
	0    1    1    0   
$EndComp
Wire Wire Line
	10225 4200 10275 4200
Wire Wire Line
	10275 4200 10275 4050
Wire Wire Line
	10225 4425 10425 4425
Wire Wire Line
	9925 4425 9825 4425
Wire Wire Line
	9925 4200 9825 4200
$Comp
L Device:C C1
U 1 1 5E215C9F
P 4150 2600
F 0 "C1" H 4265 2646 50  0000 L CNN
F 1 "0.1u" H 4265 2555 50  0000 L CNN
F 2 "" H 4188 2450 50  0001 C CNN
F 3 "~" H 4150 2600 50  0001 C CNN
	1    4150 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 2450 4150 2450
Wire Wire Line
	4400 2750 4150 2750
$Comp
L Device:C C2
U 1 1 5E2174FD
P 6250 2600
F 0 "C2" H 6365 2646 50  0000 L CNN
F 1 "0.1u" H 6365 2555 50  0000 L CNN
F 2 "" H 6288 2450 50  0001 C CNN
F 3 "~" H 6250 2600 50  0001 C CNN
	1    6250 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 2450 6250 2450
Wire Wire Line
	6250 2750 6000 2750
$Comp
L Device:C C3
U 1 1 5E218A45
P 6150 2950
F 0 "C3" V 6000 2950 50  0000 C CNN
F 1 "0.1u" V 6300 2950 50  0000 C CNN
F 2 "" H 6188 2800 50  0001 C CNN
F 3 "~" H 6150 2950 50  0001 C CNN
	1    6150 2950
	0    1    1    0   
$EndComp
$Comp
L Device:C C4
U 1 1 5E219C1D
P 6300 3250
F 0 "C4" V 6150 3250 50  0000 C CNN
F 1 "0.1u" V 6450 3250 50  0000 C CNN
F 2 "" H 6338 3100 50  0001 C CNN
F 3 "~" H 6300 3250 50  0001 C CNN
	1    6300 3250
	0    1    1    0   
$EndComp
Wire Wire Line
	6150 3250 6000 3250
$Comp
L power:GND #PWR014
U 1 1 5E21C33E
P 6700 3175
F 0 "#PWR014" H 6700 2925 50  0001 C CNN
F 1 "GND" H 6705 3002 50  0000 C CNN
F 2 "" H 6700 3175 50  0001 C CNN
F 3 "" H 6700 3175 50  0001 C CNN
	1    6700 3175
	1    0    0    -1  
$EndComp
Wire Wire Line
	6700 2950 6700 3175
Wire Wire Line
	6300 2950 6450 2950
Wire Wire Line
	6450 3250 6450 2950
Connection ~ 6450 2950
Wire Wire Line
	6450 2950 6700 2950
$Comp
L power:GND #PWR013
U 1 1 5E21F7F9
P 5200 4550
F 0 "#PWR013" H 5200 4300 50  0001 C CNN
F 1 "GND" H 5205 4377 50  0000 C CNN
F 2 "" H 5200 4550 50  0001 C CNN
F 3 "" H 5200 4550 50  0001 C CNN
	1    5200 4550
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR012
U 1 1 5E2205ED
P 5200 2150
F 0 "#PWR012" H 5200 2000 50  0001 C CNN
F 1 "+5V" H 5215 2323 50  0000 C CNN
F 2 "" H 5200 2150 50  0001 C CNN
F 3 "" H 5200 2150 50  0001 C CNN
	1    5200 2150
	1    0    0    -1  
$EndComp
NoConn ~ 4400 3650
NoConn ~ 6000 3650
NoConn ~ 4400 4050
NoConn ~ 6000 4050
$Comp
L Connector:AudioJack3 J1
U 1 1 5E2249E5
P 4150 1575
F 0 "J1" H 4132 1900 50  0000 C CNN
F 1 "RS232_SERIAL" H 4025 1800 50  0000 C CNN
F 2 "" H 4150 1575 50  0001 C CNN
F 3 "~" H 4150 1575 50  0001 C CNN
	1    4150 1575
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR011
U 1 1 5E2249F1
P 4575 1300
F 0 "#PWR011" H 4575 1050 50  0001 C CNN
F 1 "GND" H 4580 1127 50  0000 C CNN
F 2 "" H 4575 1300 50  0001 C CNN
F 3 "" H 4575 1300 50  0001 C CNN
	1    4575 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 1475 4350 1300
Wire Wire Line
	4350 1300 4575 1300
Wire Wire Line
	4350 1675 4350 1725
NoConn ~ 3275 5650
NoConn ~ 1875 6750
$Comp
L Regulator_Linear:LM1117-3.3 U5
U 1 1 5E23146E
P 1300 5025
F 0 "U5" H 1300 5267 50  0000 C CNN
F 1 "LM1117-3.3" H 1300 5176 50  0000 C CNN
F 2 "" H 1300 5025 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm1117.pdf" H 1300 5025 50  0001 C CNN
	1    1300 5025
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR01
U 1 1 5E23779E
P 825 4900
F 0 "#PWR01" H 825 4750 50  0001 C CNN
F 1 "+5V" H 840 5073 50  0000 C CNN
F 2 "" H 825 4900 50  0001 C CNN
F 3 "" H 825 4900 50  0001 C CNN
	1    825  4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	825  4900 825  5025
Wire Wire Line
	825  5025 1000 5025
$Comp
L power:GND #PWR02
U 1 1 5E23A7A2
P 1300 5425
F 0 "#PWR02" H 1300 5175 50  0001 C CNN
F 1 "GND" H 1305 5252 50  0000 C CNN
F 2 "" H 1300 5425 50  0001 C CNN
F 3 "" H 1300 5425 50  0001 C CNN
	1    1300 5425
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 5325 1300 5350
Wire Wire Line
	3400 5950 3275 5950
$Comp
L power:GND #PWR010
U 1 1 5E23E240
P 3750 5750
F 0 "#PWR010" H 3750 5500 50  0001 C CNN
F 1 "GND" H 3755 5577 50  0000 C CNN
F 2 "" H 3750 5750 50  0001 C CNN
F 3 "" H 3750 5750 50  0001 C CNN
	1    3750 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3275 5750 3275 5700
Wire Wire Line
	3275 5700 3750 5700
Wire Wire Line
	3750 5700 3750 5750
$Comp
L power:GND #PWR05
U 1 1 5E23FDFB
P 1800 6075
F 0 "#PWR05" H 1800 5825 50  0001 C CNN
F 1 "GND" H 1805 5902 50  0000 C CNN
F 2 "" H 1800 6075 50  0001 C CNN
F 3 "" H 1800 6075 50  0001 C CNN
	1    1800 6075
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR06
U 1 1 5E244DDB
P 1900 7050
F 0 "#PWR06" H 1900 6900 50  0001 C CNN
F 1 "+5V" H 1915 7223 50  0000 C CNN
F 2 "" H 1900 7050 50  0001 C CNN
F 3 "" H 1900 7050 50  0001 C CNN
	1    1900 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 7050 2275 7050
Text GLabel 6250 3600 2    50   Input ~ 0
RS_SERIAL_OUT
Wire Wire Line
	6000 3450 6000 3600
Wire Wire Line
	6000 3600 6250 3600
Text GLabel 6250 3850 2    50   Input ~ 0
RS_SERIAL_IN
Wire Wire Line
	6250 3850 6000 3850
Text GLabel 4225 3450 0    50   Input ~ 0
ALT_SERIAL_OUT
Text GLabel 4825 1725 2    50   Input ~ 0
RS_SERIAL_OUT
Wire Wire Line
	4350 1575 4800 1575
Text GLabel 4800 1575 2    50   Input ~ 0
RS_SERIAL_IN
Wire Wire Line
	4350 1725 4825 1725
Wire Wire Line
	4225 3450 4400 3450
Text GLabel 4225 3850 0    50   Input ~ 0
ALT_SERIAL_IN
Wire Wire Line
	4225 3850 4400 3850
Text GLabel 1325 2450 0    50   Input ~ 0
ALT_SERIAL_OUT
Wire Wire Line
	1325 2450 1500 2450
Text GLabel 1275 2275 0    50   Input ~ 0
ALT_SERIAL_IN
Text GLabel 1325 1850 0    50   Input ~ 0
MIDI_SERIAL_IN
Text GLabel 1400 1675 0    50   Input ~ 0
MIDI_SERIAL_OUT
Wire Wire Line
	1275 2275 1275 2350
Wire Wire Line
	1275 2350 1500 2350
Wire Wire Line
	1400 1675 1400 1750
Wire Wire Line
	1400 1750 1500 1750
Wire Wire Line
	1325 1850 1500 1850
$Comp
L power:GND #PWR03
U 1 1 5E27B159
P 1350 2050
F 0 "#PWR03" H 1350 1800 50  0001 C CNN
F 1 "GND" H 1355 1877 50  0000 C CNN
F 2 "" H 1350 2050 50  0001 C CNN
F 3 "" H 1350 2050 50  0001 C CNN
	1    1350 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 1950 1350 1950
Wire Wire Line
	1350 1950 1350 2050
Wire Wire Line
	1500 2050 1350 2050
Connection ~ 1350 2050
$Comp
L power:GND #PWR07
U 1 1 5E27F7BB
P 3150 1775
F 0 "#PWR07" H 3150 1525 50  0001 C CNN
F 1 "GND" H 3150 1825 50  0000 C CNN
F 2 "" H 3150 1775 50  0001 C CNN
F 3 "" H 3150 1775 50  0001 C CNN
	1    3150 1775
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR09
U 1 1 5E282880
P 3425 2050
F 0 "#PWR09" H 3425 1900 50  0001 C CNN
F 1 "+5V" H 3450 2225 50  0000 C CNN
F 2 "" H 3425 2050 50  0001 C CNN
F 3 "" H 3425 2050 50  0001 C CNN
	1    3425 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3025 1775 3025 1850
Wire Wire Line
	3025 1850 2900 1850
Text GLabel 2950 1950 2    50   Input ~ 0
RST_HOST
Wire Wire Line
	3425 2050 2900 2050
Wire Wire Line
	3025 1775 3150 1775
Text GLabel 1825 5850 0    50   Input ~ 0
RST_HOST
Wire Wire Line
	1875 5850 1825 5850
Text GLabel 3450 6450 2    50   Input ~ 0
SKC_HOST
Text GLabel 3450 6550 2    50   Input ~ 0
MISO_HOST
Text GLabel 3450 6650 2    50   Input ~ 0
MOSI_HOST
Text GLabel 3450 6750 2    50   Input ~ 0
SS_HOST
Wire Wire Line
	3450 6450 3275 6450
Wire Wire Line
	3450 6550 3275 6550
Wire Wire Line
	3450 6650 3275 6650
Wire Wire Line
	3450 6750 3275 6750
Text GLabel 3000 2550 2    50   Input ~ 0
SKC_HOST
Text GLabel 3000 2650 2    50   Input ~ 0
MISO_HOST
Text GLabel 3000 2750 2    50   Input ~ 0
MOSI_HOST
Text GLabel 3000 2850 2    50   Input ~ 0
SS_HOST
Wire Wire Line
	3000 2550 2900 2550
Wire Wire Line
	3000 2650 2900 2650
Wire Wire Line
	3000 2750 2900 2750
Wire Wire Line
	3000 2850 2900 2850
NoConn ~ 1500 2150
NoConn ~ 1500 2250
NoConn ~ 1500 2550
NoConn ~ 1500 2650
NoConn ~ 1500 2750
NoConn ~ 1500 2850
NoConn ~ 2900 2150
NoConn ~ 2900 2250
NoConn ~ 2900 2350
NoConn ~ 2900 2450
NoConn ~ 2900 1750
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5E2D96EE
P 750 5025
F 0 "#FLG01" H 750 5100 50  0001 C CNN
F 1 "PWR_FLAG" V 625 4900 50  0000 L CNN
F 2 "" H 750 5025 50  0001 C CNN
F 3 "~" H 750 5025 50  0001 C CNN
	1    750  5025
	0    -1   -1   0   
$EndComp
Wire Wire Line
	825  5025 750  5025
Connection ~ 825  5025
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5E2DCB0C
P 1100 5350
F 0 "#FLG02" H 1100 5425 50  0001 C CNN
F 1 "PWR_FLAG" V 975 5225 50  0000 L CNN
F 2 "" H 1100 5350 50  0001 C CNN
F 3 "~" H 1100 5350 50  0001 C CNN
	1    1100 5350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1100 5350 1300 5350
Connection ~ 1300 5350
Wire Wire Line
	1300 5350 1300 5425
Wire Wire Line
	8800 2575 9000 2575
Wire Wire Line
	9000 2575 9000 2425
Connection ~ 8800 2575
Wire Wire Line
	1875 5950 1800 5950
Wire Wire Line
	1800 5950 1800 6075
Text GLabel 1725 5025 2    50   Input ~ 0
3.3v
Wire Wire Line
	1600 5025 1725 5025
Text GLabel 3400 5950 2    50   Input ~ 0
3.3v
Wire Wire Line
	2900 1950 2950 1950
$EndSCHEMATC
