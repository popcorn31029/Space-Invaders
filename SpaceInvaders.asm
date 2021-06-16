TITLE Space Invaders
INCLUDE Irvine32.inc
main 		 EQU start@0

COORDB STRUCT
	x BYTE ?
	y BYTE ?
COORDB ENDS

PrintObj PROTO, pos: COORDB, img: PTR DWORD, num: DWORD, color: DWORD
PosAssign PROTO, pos1x: ptr BYTE, pos1y: ptr BYTE, pos2x: ptr BYTE, pos2y: ptr BYTE
ClearPre PROTO, pos: COORDB, img: PTR DWORD, num: DWORD
PrintBoxLine PROTO, pos: COORDB, lines: PTR DWORD, num: DWORD
Collision PROTO, hPos: COORDB, ePos: COORDB
Collision2 PROTO, bPos: COORDB, hPos: COORDB
Collision3 PROTO, bPos: COORDB, buPos: COORDB

.data
    line  byte 112 dup(0dbh)
	line2 byte 10 dup(0dbh), 218, 196, 191, 0, 218, 196, 191, 0, 218, 196,  0, 0, 218, 196,   0, 0, 218, 196,   0, 0, 83 dup(0dbh)
	line3 byte 10 dup(0dbh), 195, 196, 217, 0, 195, 196, 217, 0, 195, 196,  0, 0, 192, 196, 191, 0, 192, 196, 191, 0, 83 dup(0dbh)
	line4 byte 10 dup(0dbh), 179,   0,   0, 0, 179,   0,  92, 0, 192, 196,  0, 0,   0, 196, 217, 0,   0, 196, 217, 0, 83 dup(0dbh)
	line5 byte 14 dup(0dbh), 218, 196,   0, 0, 218, 196, 191, 0,   0, 94,  0, 0, 218, 196,   0, 0, 218, 196,   0, 0, 79 dup(0dbh)
	line6 byte 14 dup(0dbh), 192, 196, 191, 0, 195, 196, 217, 0,  47, 95, 92, 0, 179,   0,   0, 0, 195, 196,   0, 0, 79 dup(0dbh)
	line7 byte 14 dup(0dbh),   0, 196, 217, 0, 179,   0,   0, 0,  47,   0, 92, 0, 192, 196,   0, 0, 192, 196,   0, 0, 79 dup(0dbh)
	
	start0 word 4 dup(0), 14 dup(0fh), 2 dup(0), 20 dup(0fh), 10 dup(0), 2 dup(0fh),16 dup(0),16 dup(0fh),  6 dup(0),18 dup(0fh),  4 dup(0)
	start1 word 2 dup(0),  4 dup(0fh), 22 dup(0), 2 dup(0fh), 18 dup(0), 2 dup(0fh), 2 dup(0), 2 dup(0fh), 14 dup(0), 2 dup(0fh), 14 dup(0), 2 dup(0fh), 12 dup(0), 2 dup(0fh), 12 dup(0)
	start2 word 2 dup(0),  2 dup(0fh), 24 dup(0), 2 dup(0fh), 18 dup(0), 2 dup(0fh), 2 dup(0), 2 dup(0fh), 14 dup(0), 2 dup(0fh), 14 dup(0), 2 dup(0fh), 12 dup(0), 2 dup(0fh), 12 dup(0)
	start3 word 2 dup(0),  2 dup(0fh), 24 dup(0), 2 dup(0fh), 16 dup(0), 2 dup(0fh), 6 dup(0), 2 dup(0fh), 12 dup(0), 2 dup(0fh), 14 dup(0), 2 dup(0fh), 12 dup(0), 2 dup(0fh), 12 dup(0)
	start5 word 2 dup(0),  2 dup(0fh), 24 dup(0), 2 dup(0fh), 14 dup(0), 2 dup(0fh),10 dup(0), 2 dup(0fh), 10 dup(0), 2 dup(0fh), 14 dup(0), 2 dup(0fh), 12 dup(0), 2 dup(0fh), 12 dup(0)
	start7 word 4 dup(0),  8 dup(0fh), 16 dup(0), 2 dup(0fh), 12 dup(0), 2 dup(0fh),12 dup(0), 2 dup(0fh), 10 dup(0),16 dup(0fh), 14 dup(0), 2 dup(0fh), 12 dup(0)
	start8 word 12 dup(0), 6 dup(0fh), 10 dup(0), 2 dup(0fh), 12 dup(0),18 dup(0fh), 8 dup(0), 4 dup(0fh), 26 dup(0), 2 dup(0fh), 12 dup(0)
	start9 word 18 dup(0), 2 dup(0fh),  8 dup(0), 2 dup(0fh), 10 dup(0), 2 dup(0fh),16 dup(0), 2 dup(0fh),  8 dup(0), 2 dup(0fh),  2 dup(0), 2 dup(0fh), 24 dup(0), 2 dup(0fh), 12 dup(0)
	start10 word 18 dup(0), 2 dup(0fh), 8 dup(0), 2 dup(0fh), 10 dup(0), 2 dup(0fh),16 dup(0), 2 dup(0fh),  8 dup(0), 2 dup(0fh),  4 dup(0), 2 dup(0fh), 22 dup(0), 2 dup(0fh), 12 dup(0)
	start11 word 18 dup(0), 2 dup(0fh), 8 dup(0), 2 dup(0fh),  8 dup(0), 2 dup(0fh),20 dup(0), 2 dup(0fh),  6 dup(0), 2 dup(0fh),  6 dup(0), 2 dup(0fh), 20 dup(0), 2 dup(0fh), 12 dup(0)
	start12 word 18 dup(0), 2 dup(0fh), 8 dup(0), 2 dup(0fh),  8 dup(0), 2 dup(0fh),20 dup(0), 2 dup(0fh),  6 dup(0), 2 dup(0fh),  8 dup(0), 2 dup(0fh), 18 dup(0), 2 dup(0fh), 12 dup(0)
	start13 word 18 dup(0), 2 dup(0fh), 8 dup(0), 2 dup(0fh),  8 dup(0), 2 dup(0fh),20 dup(0), 2 dup(0fh),  6 dup(0), 2 dup(0fh), 10 dup(0), 2 dup(0fh), 16 dup(0), 2 dup(0fh), 12 dup(0)
	start14 word 18 dup(0), 2 dup(0fh), 8 dup(0), 2 dup(0fh),  6 dup(0), 2 dup(0fh),24 dup(0), 2 dup(0fh),  4 dup(0), 2 dup(0fh), 12 dup(0), 2 dup(0fh), 14 dup(0), 2 dup(0fh), 12 dup(0)
	start15 word  4 dup(0),14 dup(0fh),10 dup(0), 2 dup(0fh),  6 dup(0), 2 dup(0fh),24 dup(0), 2 dup(0fh),  4 dup(0), 2 dup(0fh), 12 dup(0), 2 dup(0fh), 14 dup(0), 2 dup(0fh), 12 dup(0)
	
	starts0 word 4 dup(0), 14 dup(0ch), 2 dup(0), 20 dup(0ch), 10 dup(0), 2 dup(0ch),16 dup(0),16 dup(0ch),  6 dup(0),18 dup(0ch),  4 dup(0)
	starts1 word 2 dup(0),  4 dup(0ch), 22 dup(0), 2 dup(0ch), 18 dup(0), 2 dup(0ch), 2 dup(0), 2 dup(0ch), 14 dup(0), 2 dup(0ch), 14 dup(0), 2 dup(0ch), 12 dup(0), 2 dup(0ch), 12 dup(0)
	starts2 word 2 dup(0),  2 dup(0ch), 24 dup(0), 2 dup(0ch), 18 dup(0), 2 dup(0ch), 2 dup(0), 2 dup(0ch), 14 dup(0), 2 dup(0ch), 14 dup(0), 2 dup(0ch), 12 dup(0), 2 dup(0ch), 12 dup(0)
	starts3 word 2 dup(0),  2 dup(0ch), 24 dup(0), 2 dup(0ch), 16 dup(0), 2 dup(0ch), 6 dup(0), 2 dup(0ch), 12 dup(0), 2 dup(0ch), 14 dup(0), 2 dup(0ch), 12 dup(0), 2 dup(0ch), 12 dup(0)
	starts5 word 2 dup(0),  2 dup(0ch), 24 dup(0), 2 dup(0ch), 14 dup(0), 2 dup(0ch),10 dup(0), 2 dup(0ch), 10 dup(0), 2 dup(0ch), 14 dup(0), 2 dup(0ch), 12 dup(0), 2 dup(0ch), 12 dup(0)
	starts7 word 4 dup(0),  8 dup(0ch), 16 dup(0), 2 dup(0ch), 12 dup(0), 2 dup(0ch),12 dup(0), 2 dup(0ch), 10 dup(0),16 dup(0ch), 14 dup(0), 2 dup(0ch), 12 dup(0)
	starts8 word 12 dup(0), 6 dup(0ch), 10 dup(0), 2 dup(0ch), 12 dup(0),18 dup(0ch), 8 dup(0), 4 dup(0ch), 26 dup(0), 2 dup(0ch), 12 dup(0)
	starts9 word 18 dup(0), 2 dup(0ch),  8 dup(0), 2 dup(0ch), 10 dup(0), 2 dup(0ch),16 dup(0), 2 dup(0ch),  8 dup(0), 2 dup(0ch),  2 dup(0), 2 dup(0ch), 24 dup(0), 2 dup(0ch), 12 dup(0)
	starts10 word 18 dup(0), 2 dup(0ch), 8 dup(0), 2 dup(0ch), 10 dup(0), 2 dup(0ch),16 dup(0), 2 dup(0ch),  8 dup(0), 2 dup(0ch),  4 dup(0), 2 dup(0ch), 22 dup(0), 2 dup(0ch), 12 dup(0)
	starts11 word 18 dup(0), 2 dup(0ch), 8 dup(0), 2 dup(0ch),  8 dup(0), 2 dup(0ch),20 dup(0), 2 dup(0ch),  6 dup(0), 2 dup(0ch),  6 dup(0), 2 dup(0ch), 20 dup(0), 2 dup(0ch), 12 dup(0)
	starts12 word 18 dup(0), 2 dup(0ch), 8 dup(0), 2 dup(0ch),  8 dup(0), 2 dup(0ch),20 dup(0), 2 dup(0ch),  6 dup(0), 2 dup(0ch),  8 dup(0), 2 dup(0ch), 18 dup(0), 2 dup(0ch), 12 dup(0)
	starts13 word 18 dup(0), 2 dup(0ch), 8 dup(0), 2 dup(0ch),  8 dup(0), 2 dup(0ch),20 dup(0), 2 dup(0ch),  6 dup(0), 2 dup(0ch), 10 dup(0), 2 dup(0ch), 16 dup(0), 2 dup(0ch), 12 dup(0)
	starts14 word 18 dup(0), 2 dup(0ch), 8 dup(0), 2 dup(0ch),  6 dup(0), 2 dup(0ch),24 dup(0), 2 dup(0ch),  4 dup(0), 2 dup(0ch), 12 dup(0), 2 dup(0ch), 14 dup(0), 2 dup(0ch), 12 dup(0)
	starts15 word  4 dup(0),14 dup(0ch),10 dup(0), 2 dup(0ch),  6 dup(0), 2 dup(0ch),24 dup(0), 2 dup(0ch),  4 dup(0), 2 dup(0ch), 12 dup(0), 2 dup(0ch), 14 dup(0), 2 dup(0ch), 12 dup(0)
	
	starta0 word 4 dup(0), 14 dup(0eh), 2 dup(0), 20 dup(0eh), 10 dup(0), 2 dup(0eh),16 dup(0),16 dup(0eh),  6 dup(0),18 dup(0eh),  4 dup(0)
	starta1 word 2 dup(0),  4 dup(0eh), 22 dup(0), 2 dup(0eh), 18 dup(0), 2 dup(0eh), 2 dup(0), 2 dup(0eh), 14 dup(0), 2 dup(0eh), 14 dup(0), 2 dup(0eh), 12 dup(0), 2 dup(0eh), 12 dup(0)
	starta2 word 2 dup(0),  2 dup(0eh), 24 dup(0), 2 dup(0eh), 18 dup(0), 2 dup(0eh), 2 dup(0), 2 dup(0eh), 14 dup(0), 2 dup(0eh), 14 dup(0), 2 dup(0eh), 12 dup(0), 2 dup(0eh), 12 dup(0)
	starta3 word 2 dup(0),  2 dup(0eh), 24 dup(0), 2 dup(0eh), 16 dup(0), 2 dup(0eh), 6 dup(0), 2 dup(0eh), 12 dup(0), 2 dup(0eh), 14 dup(0), 2 dup(0eh), 12 dup(0), 2 dup(0eh), 12 dup(0)
	starta5 word 2 dup(0),  2 dup(0eh), 24 dup(0), 2 dup(0eh), 14 dup(0), 2 dup(0eh),10 dup(0), 2 dup(0eh), 10 dup(0), 2 dup(0eh), 14 dup(0), 2 dup(0eh), 12 dup(0), 2 dup(0eh), 12 dup(0)
	starta7 word 4 dup(0),  8 dup(0eh), 16 dup(0), 2 dup(0eh), 12 dup(0), 2 dup(0eh),12 dup(0), 2 dup(0eh), 10 dup(0),16 dup(0eh), 14 dup(0), 2 dup(0eh), 12 dup(0)
	starta8 word 12 dup(0), 6 dup(0eh), 10 dup(0), 2 dup(0eh), 12 dup(0),18 dup(0eh), 8 dup(0), 4 dup(0eh), 26 dup(0), 2 dup(0eh), 12 dup(0)
	starta9 word 18 dup(0), 2 dup(0eh),  8 dup(0), 2 dup(0eh), 10 dup(0), 2 dup(0eh),16 dup(0), 2 dup(0eh),  8 dup(0), 2 dup(0eh),  2 dup(0), 2 dup(0eh), 24 dup(0), 2 dup(0eh), 12 dup(0)
	starta10 word 18 dup(0), 2 dup(0eh), 8 dup(0), 2 dup(0eh), 10 dup(0), 2 dup(0eh),16 dup(0), 2 dup(0eh),  8 dup(0), 2 dup(0eh),  4 dup(0), 2 dup(0eh), 22 dup(0), 2 dup(0eh), 12 dup(0)
	starta11 word 18 dup(0), 2 dup(0eh), 8 dup(0), 2 dup(0eh),  8 dup(0), 2 dup(0eh),20 dup(0), 2 dup(0eh),  6 dup(0), 2 dup(0eh),  6 dup(0), 2 dup(0eh), 20 dup(0), 2 dup(0eh), 12 dup(0)
	starta12 word 18 dup(0), 2 dup(0eh), 8 dup(0), 2 dup(0eh),  8 dup(0), 2 dup(0eh),20 dup(0), 2 dup(0eh),  6 dup(0), 2 dup(0eh),  8 dup(0), 2 dup(0eh), 18 dup(0), 2 dup(0eh), 12 dup(0)
	starta13 word 18 dup(0), 2 dup(0eh), 8 dup(0), 2 dup(0eh),  8 dup(0), 2 dup(0eh),20 dup(0), 2 dup(0eh),  6 dup(0), 2 dup(0eh), 10 dup(0), 2 dup(0eh), 16 dup(0), 2 dup(0eh), 12 dup(0)
	starta14 word 18 dup(0), 2 dup(0eh), 8 dup(0), 2 dup(0eh),  6 dup(0), 2 dup(0eh),24 dup(0), 2 dup(0eh),  4 dup(0), 2 dup(0eh), 12 dup(0), 2 dup(0eh), 14 dup(0), 2 dup(0eh), 12 dup(0)
	starta15 word  4 dup(0),14 dup(0eh),10 dup(0), 2 dup(0eh),  6 dup(0), 2 dup(0eh),24 dup(0), 2 dup(0eh),  4 dup(0), 2 dup(0eh), 12 dup(0), 2 dup(0eh), 14 dup(0), 2 dup(0eh), 12 dup(0)

	space0 word 32 dup(0ah), 56 dup(0bh), 2 dup(0), 22 dup(0bh)
	space1 word 32 dup(0ah), 42 dup(0bh), 2 dup(0), 36 dup(0bh)
	space2 word 32 dup(0ah), 30 dup(0bh), 2 dup(0), 48 dup(0bh)
	space3 word 30 dup(0ah), 22 dup(0bh), 4 dup(0), 56 dup(0bh)
	space4 word 30 dup(0ah), 14 dup(0bh), 4 dup(0), 64 dup(0bh)
	space41 word 30 dup(0ah), 14 dup(0bh),2 dup(0eh), 2 dup(0), 64 dup(0bh)
	space5 word 26 dup(0ah),  8 dup(0bh), 6 dup(0), 72 dup(0bh)
	space6 word 26 dup(0ah),  6 dup(0bh),10 dup(0eh), 70 dup(0bh)
	space7 word 24 dup(0ah), 10 dup(0bh), 6 dup(0), 38 dup(0bh), 6 dup(0), 28 dup(0bh)
	space8 word 24 dup(0ah),  8 dup(0bh),10 dup(0), 36 dup(0bh), 6 dup(0), 28 dup(0bh)
	space9 word 22 dup(0ah), 10 dup(0bh),10 dup(0), 34 dup(0bh),10 dup(0), 26 dup(0bh)
    space10 word 22 dup(0ah),  6 dup(0bh),18 dup(0eh), 30 dup(0bh),10 dup(0), 26 dup(0bh)
	space11 word 18 dup(2), 14 dup(0bh),10 dup(0), 34 dup(0bh), 8 dup(0), 28 dup(0bh)
	space12 word 14 dup(2), 18 dup(0bh),10 dup(0), 38 dup(0bh), 2 dup(0), 30 dup(0bh)
	
	space13 word 18 dup(2), 12 dup(0bh),18 dup(0), 28 dup(0bh), 8 dup(0), 28 dup(0bh)
	space14 word 14 dup(2), 16 dup(0bh),18 dup(0), 32 dup(0bh), 2 dup(0), 30 dup(0bh)
    space15 word 6  dup(2),  6 dup(6h), 18 dup(0bh), 4 dup(0),  2 dup(0dh), 2 dup(0),   2 dup(0dh),  2 dup(0), 2 dup(0dh), 4 dup(0),18 dup(0bh), 4 dup(4),   4 dup(0bh),6 dup(4), 6 dup(0), 26 dup(0bh)
	space16 word 12 dup(6), 14 dup(0bh), 6 dup(0eh), 2 dup(0dh), 4 dup(0), 2 dup(0dh), 4 dup(0), 2 dup(0dh), 6 dup(0eh),10 dup(0bh),18 dup(4),  2 dup(0), 2 dup(0bh), 2 dup(0), 26 dup(0bh)
	space17 word 2 dup(0bh), 8 dup(6),  12 dup(0bh), 34 dup(0eh), 4 dup(0bh),18 dup(4), 2 dup(0bh),2 dup(0), 2 dup(0bh), 4 dup(0), 24 dup(0bh)
	space18 word 2 dup(0bh), 8 dup(6),  16 dup(0bh), 26 dup(0eh),10 dup(2),  14 dup(4), 4 dup(0bh),2 dup(0),30 dup(0bh)
	space19 word 4 dup(0bh), 6 dup(6),  18 dup(0bh),  2 dup(2),  18 dup(0eh),14 dup(2),12 dup(4),  4 dup(2), 10 dup(0), 24 dup(0bh)
	space20 word 4 dup(0bh), 6 dup(6),   8 dup(0bh), 12 dup(2),  18 dup(0),  18 dup(2), 8 dup(4),  4 dup(2),  2 dup(0),  6 dup(2),  2 dup(0), 24 dup(0bh)
	space21 word 4 dup(0bh), 6 dup(6),  20 dup(2),   18 dup(0),  18 dup(2),   4 dup(4), 6 dup(2), 4 dup(0), 6 dup(2), 2 dup(0), 24 dup(1)

	space22 word 22 dup(0ah), 24 dup(0bh), 12 dup(0), 18 dup(0bh), 10 dup(0),  26 dup(0bh);5
   space221 word 22 dup(0ah), 18 dup(0bh), 22 dup(0), 14 dup(0bh), 10 dup(0),  26 dup(0bh);5
	space23 word 18 dup(2),   16 dup(0bh), 32 dup(0), 10 dup(0bh),  8 dup(0),  28 dup(0bh);6
	space24 word 14 dup(2),   16 dup(0bh), 38 dup(0), 12 dup(0bh),  2 dup(0),  30 dup(0bh);7
	space25 word 6  dup(2),   6 dup(6h), 16 dup(0bh), 18 dup(0),    2 dup(0dh),12 dup(0),   2 dup(0dh), 8 dup(0), 4 dup(0dbh), 6 dup(4),   6 dup(0), 26 dup(0bh);8
	space26 word 12 dup(6),  14 dup(0bh),20 dup(0),    2 dup(0dh), 14 dup(0),  2  dup(0dh), 8 dup(0)   ,8 dup(4), 2 dup(0),    2 dup(0bh), 2 dup(0), 26 dup(0bh);9
	space27 word 2 dup(0bh), 8 dup(6), 14 dup(0dbh), 10 dup(0), 2 dup(0dh), 10 dup(0), 2 dup(0dh), 14 dup(0), 2 dup(0), 10 dup(0), 4 dup(4),  2 dup(0bh), 2 dup(0),   2 dup(0bh),4 dup(0), 24 dup(0bh);10
	space28 word 2 dup(0bh), 8 dup(6),  14 dup(0dbh), 10 dup(0), 2 dup(0dh), 12 dup(0), 2 dup(2dh), 14 dup(0), 2 dup(0dh), 10 dup(0), 2 dup(0eh), 2 dup(0bh), 2 dup(0), 30 dup(0bh);11
	space29 word 4 dup(0bh), 6 dup(6), 12 dup(0dbh), 10 dup(0), 2 dup(0dh), 14 dup(0), 2 dup(0dh), 16 dup(0), 2 dup(0dh), 8 dup(0), 14 dup(0eh), 22 dup(0bh);12
	space30 word 4 dup(0bh), 6 dup(6),  8 dup(0bh), 4 dup(2), 10 dup(0), 2 dup(0dh), 14 dup(0), 2 dup(0dh), 16 dup(0), 2 dup(0dh), 10 dup(0), 12 dup(0eh), 22 dup(0bh);13
	space31 word 4 dup(0bh), 6 dup(6), 12 dup(2), 8 dup(0), 2 dup(0dh), 16 dup(0), 2 dup(0), 16 dup(0), 2 dup(0), 10 dup(0), 8 dup(0eh), 2 dup(0), 24 dup(1);14
	space32 word 4 dup(2),   8 dup(6),  8 dup(2), 2 dup(0eh), 8 dup(0), 2 dup(0dh), 16 dup(0), 2 dup(0dh), 28 dup(0), 4 dup(0eh), 4 dup(2), 2 dup(0),  2 dup(2), 22 dup(1);15
	space33 word 4 dup(2),   8 dup(6),  6 dup(2), 4 dup(0eh), 8 dup(0), 2 dup(0dh), 18 dup(0), 2 dup(0dh), 18 dup(0), 8 dup(0eh), 12 dup(2), 22 dup(1);16
	space34 word 4 dup(2),   8 dup(6), 10 dup(0eh), 8 dup(0), 2 dup(0dh), 26 dup(0), 12 dup(0eh), 6 dup(0), 14 dup(2) ,22 dup(1);17
	space341 word 4 dup(2),   4 dup(6), 14 dup(0eh), 20 dup(0), 16 dup(0eh), 18 dup(0), 14 dup(2), 22 dup(1);17
	space35 word 2 dup(2),  6 dup(6), 34 dup(0eh), 32 dup(0), 16 dup(2), 22 dup(1);18
	space36 word 2 dup(2),  14 dup(6), 10 dup(2), 46 dup(0), 16 dup(2), 2 dup(6), 22 dup(1);19
	space37 word 18 dup(6), 10 dup(2), 42 dup(0), 16 dup(2), 4 dup(6), 22 dup(1);20
	space38 word 20 dup(6), 10 dup(2), 38 dup(0), 16 dup(2), 4 dup(6), 24 dup(1);21
	space39 word 32 dup(2), 32 dup(0), 18 dup(2), 6 dup(6), 24 dup(1);22
	space40 word 36 dup(2), 24 dup(0), 20 dup(2), 8 dup(6), 24 dup(1);23
   space411 dword 40 dup(2), 16 dup(0), 22 dup(2), 10 dup(6), 24 dup(1);24
   
    last0 dword 22 dup(0ah), 24 dup(0bh), 12 dup(0), 18 dup(0bh), 10 dup(0),  26 dup(0bh);5
    last1 dword 22 dup(0ah), 18 dup(0bh), 22 dup(0), 14 dup(0bh), 10 dup(0),  26 dup(0bh);5
	last2 dword 18 dup(2),   16 dup(0bh), 32 dup(0), 10 dup(0bh),  8 dup(0),  28 dup(0bh);6
	last3 dword 14 dup(2),   16 dup(0bh), 38 dup(0), 12 dup(0bh),  2 dup(0),  30 dup(0bh);7
	last4 dword 6  dup(2),   6 dup(6h), 16 dup(0bh), 18 dup(0),    2 dup(0dh),12 dup(0),   2 dup(0dh), 8 dup(0), 4 dup(0dbh), 6 dup(4),   6 dup(0), 26 dup(0bh);8
	last5 dword 12 dup(6),  14 dup(0bh),20 dup(0),    2 dup(0dh), 14 dup(0),  2  dup(0dh), 8 dup(0)   ,8 dup(4), 2 dup(0),    2 dup(0bh), 2 dup(0), 26 dup(0bh);9
	last6 dword 2 dup(0bh), 8 dup(6), 14 dup(0dbh), 10 dup(0), 2 dup(0dh), 10 dup(0), 2 dup(0dh), 14 dup(0), 2 dup(0), 10 dup(0), 4 dup(4),  2 dup(0bh), 2 dup(0),   2 dup(0bh),4 dup(0), 24 dup(0bh);10
	last7 dword 2 dup(0bh), 8 dup(6),  14 dup(0dbh), 10 dup(0), 2 dup(0dh), 12 dup(0), 2 dup(2dh), 14 dup(0), 2 dup(0dh), 10 dup(0), 2 dup(0eh), 2 dup(0bh), 2 dup(0), 30 dup(0bh);11
	last8 dword 4 dup(0bh), 6 dup(6), 12 dup(0dbh), 10 dup(0), 2 dup(0dh), 14 dup(0), 2 dup(0dh), 16 dup(0), 2 dup(0dh), 8 dup(0), 14 dup(0eh), 22 dup(0bh);12
	last9 dword 4 dup(0bh), 6 dup(6),  8 dup(0bh), 4 dup(2), 10 dup(0), 2 dup(0dh), 14 dup(0), 2 dup(0dh), 16 dup(0), 2 dup(0dh), 10 dup(0), 12 dup(0eh), 22 dup(0bh);13
	last10 dword 4 dup(0bh), 6 dup(6), 12 dup(2), 8 dup(0), 2 dup(0dh), 16 dup(0), 2 dup(0), 16 dup(0), 2 dup(0), 10 dup(0), 8 dup(0eh), 2 dup(0), 24 dup(1);14
	last11 dword 4 dup(2),   8 dup(6),  8 dup(2), 2 dup(0eh), 8 dup(0), 2 dup(0dh), 16 dup(0), 2 dup(0dh), 28 dup(0), 4 dup(0eh), 4 dup(2), 2 dup(0),  2 dup(2), 22 dup(1);15
	last12 dword 4 dup(2),   8 dup(6),  6 dup(2), 4 dup(0eh), 8 dup(0), 2 dup(0dh), 18 dup(0), 2 dup(0dh), 18 dup(0), 8 dup(0eh), 12 dup(2), 22 dup(1);16
	last13 dword 4 dup(2),   8 dup(6), 10 dup(0eh), 8 dup(0), 2 dup(0dh), 26 dup(0), 12 dup(0eh), 6 dup(0), 14 dup(2) ,22 dup(1);17
	last14 dword 4 dup(2),   4 dup(6), 14 dup(0eh), 20 dup(0), 16 dup(0eh), 18 dup(0), 14 dup(2), 22 dup(1);17
	last15 dword 2 dup(2),  6 dup(6), 34 dup(0eh), 32 dup(0), 16 dup(2), 22 dup(1);18
	last16 dword 2 dup(2),  14 dup(6), 10 dup(2), 46 dup(0), 16 dup(2), 2 dup(6), 22 dup(1);19
	last17 dword 18 dup(6), 10 dup(2), 42 dup(0), 16 dup(2), 4 dup(6), 22 dup(1);20
	last18 dword 20 dup(6), 10 dup(2), 38 dup(0), 16 dup(2), 4 dup(6), 24 dup(1);21
	last19 dword 32 dup(2), 32 dup(0), 18 dup(2), 6 dup(6), 24 dup(1);22
	last20 dword 36 dup(2), 24 dup(0), 20 dup(2), 8 dup(6), 24 dup(1);23
    last21 dword 40 dup(2), 16 dup(0), 22 dup(2), 10 dup(6), 24 dup(1);24
	
	outputhandle dword 0
	cellswritten dword ?
	xyposition coord <10, 5>
	attributes0 word 34 dup(0ah), 78 dup(0bh)
	attributes1 word 32 dup(0ah), 80 dup(0bh)
	attributes2 word 30 dup(0ah), 82 dup(0bh)
	attributes3 word 26 dup(0ah), 86 dup(0bh)
	attributes4 word 24 dup(0ah), 54 dup(0bh), 6 dup(0), 28 dup(0bh)
	attributes5 word 22 dup(0ah), 54 dup(0bh),10 dup(0), 26 dup(0bh)
	
	attributes6  word 18 dup(2),  58 dup(0bh), 8 dup(0),  28 dup(0bh)
	attributes62 word 18 dup(2),  48 dup(0bh), 6 dup(4),   4 dup(0bh), 8 dup(0), 28 dup(0bh)
	attributes7  word 14 dup(2),  66 dup(0bh), 2 dup(0),  30 dup(0bh)
	attributes72 word 14 dup(2),  46 dup(0bh),18 dup(4),   2 dup(0bh), 2 dup(0), 30 dup(0bh)
	
	attributes8  word 6  dup(2),   6 dup(6h), 54 dup(0bh), 4 dup(4), 4 dup(0bh), 6 dup(4),   6 dup(0), 26 dup(0bh)
    attributes82 word 6  dup(2),   6 dup(6h), 46 dup(0bh),22 dup(4), 6 dup(0),  26 dup(0bh)
	attributes83 word 6  dup(2),   6 dup(6h), 54 dup(0bh), 4 dup(4), 2 dup(0bh), 8 dup(4),   6 dup(0), 26 dup(0bh)
	attributes9  word 12 dup(6),  50 dup(0bh),18 dup(4),   2 dup(0), 2 dup(0bh), 2 dup(0),  26 dup(0bh)
    attributes92 word 12 dup(6),  52 dup(0bh), 8 dup(4),  8 dup(0bh),2 dup(0),   2 dup(0bh), 2 dup(0), 26 dup(0bh)
    attributes93 word 12 dup(6),  50 dup(0bh),16 dup(4),  2 dup(0bh),2 dup(0),   2 dup(0bh), 2 dup(0), 26 dup(0bh)
    attributes10 word 2 dup(0bh), 8 dup(6), 50 dup(0bh), 18 dup(4),  2 dup(0bh), 2 dup(0),   2 dup(0bh),4 dup(0), 24 dup(0bh)
   attributes102 word 2 dup(0bh), 8 dup(6), 56 dup(0bh),  4 dup(4), 10 dup(0bh), 2 dup(0),   2 dup(0bh),4 dup(0), 24 dup(0bh)
   attributes103 word 2 dup(0bh), 8 dup(6), 46 dup(0bh), 20 dup(4),  4 dup(0bh), 2 dup(0),   2 dup(0bh),4 dup(0), 24 dup(0bh)
    attributes11 word 2 dup(0bh), 8 dup(6), 32 dup(0bh), 20 dup(2), 14 dup(4),   2 dup(0bh), 2 dup(0bh),2 dup(0), 30 dup(0bh)
   attributes112 word 2 dup(0bh), 8 dup(6), 32 dup(0bh), 34 dup(2),  2 dup(0bh), 2 dup(0bh), 2 dup(0), 30 dup(0bh)
   attributes113 word 2 dup(0bh), 8 dup(6), 32 dup(0bh), 18 dup(2),  4 dup(4),   2 dup(2),   2 dup(2),  6 dup(4),  6 dup(0bh),2 dup(0), 30 dup(0bh)
    attributes12 word 4 dup(0bh), 6 dup(6), 18 dup(0bh), 34 dup(2), 12 dup(4),   4 dup(2),  10 dup(0), 24 dup(0bh)
   attributes122 word 4 dup(0bh), 6 dup(6), 18 dup(0bh), 46 dup(2),  4 dup(2),  10 dup(0),  24 dup(0bh)
   attributes123 word 4 dup(0bh), 6 dup(6), 18 dup(0bh), 40 dup(2),  4 dup(4),   6 dup(2),  10 dup(0), 24 dup(0bh)
	attributes13 word 4 dup(0bh), 6 dup(6),  8 dup(0bh), 48 dup(2),  8 dup(4),   4 dup(2),   2 dup(0),  6 dup(2),  2 dup(0), 24 dup(0bh)
   attributes132 word 4 dup(0bh), 6 dup(6),  8 dup(0bh), 56 dup(2),  4 dup(2),   2 dup(0),   6 dup(2),  2 dup(0), 24 dup(0bh)
   attributes133 word 4 dup(0bh), 6 dup(6),  8 dup(0bh), 52 dup(2),  2 dup(4),   6 dup(2),   2 dup(0),  6 dup(2),  2 dup(0), 24 dup(0bh)
 
    attributes14 word 4 dup(0bh), 6 dup(6), 56 dup(2), 4 dup(4), 6 dup(2), 4 dup(0), 6 dup(2), 2 dup(0), 24 dup(1)
   attributes142 word 4 dup(0bh), 6 dup(6), 60 dup(2), 6 dup(2), 4 dup(0), 6 dup(2), 2 dup(0),24 dup(1)
	attributes15 word 4 dup(2),   8 dup(6), 54 dup(2), 2 dup(4), 6 dup(2), 4 dup(0), 8 dup(2), 2 dup(0),  2 dup(2), 22 dup(1)
   attributes152 word 4 dup(2),   8 dup(6), 56 dup(2), 6 dup(2), 4 dup(0), 8 dup(2), 2 dup(0), 2 dup(2), 22 dup(1)

	attributes16 word 4 dup(2),   8 dup(6), 78 dup(2),22 dup(1)
	attributes17 word 4 dup(2),  10 dup(6), 76 dup(2),22 dup(1)
	attributes18 word 2 dup(2),  14 dup(6), 74 dup(2),22 dup(1)
	attributes19 word 2 dup(2),  14 dup(6), 72 dup(2), 2 dup(6), 22 dup(1)
	attributes20 word 18 dup(6), 68 dup(2), 4 dup(6), 22 dup(1)
	attributes21 word 20 dup(6), 64 dup(2), 4 dup(6), 24 dup(1)
	attributes22 word 82 dup(2), 6 dup(6), 24 dup(1)
	attributes23 word 80 dup(2), 8 dup(6), 24 dup(1)
	attributes24 word 78 dup(2),10 dup(6), 24 dup(1)
	attributes25 word 74 dup(2),14 dup(6), 24 dup(1)
	attributes26 word 68 dup(2),20 dup(6), 24 dup(1)
	attributes27 word 66 dup(2), 2 dup(6),  2 dup(0), 18 dup(6), 24 dup(1)
	attributes28 word 62 dup(2), 2 dup(6),  2 dup(0),  2 dup(6), 2 dup(0), 4 dup(6), 2 dup(0), 14 dup(6), 22 dup(1)
	attributes29 word 60 dup(2), 6 dup(6),  2 dup(0),  6 dup(6), 2 dup(0),14 dup(6),22 dup(1)
	attributes30 word 54 dup(2),12 dup(6),  2 dup(0),  6 dup(6), 2 dup(0),16 dup(6),20 dup(1)
	attributes31 word 50 dup(2),22 dup(6),  2 dup(0), 18 dup(6),20 dup(1)
	attributes32 word 44 dup(2),28 dup(6),  2 dup(0), 20 dup(6),18 dup(1)


    consoleHandle	DWORD ?
    xyPos COORDB <8,2> 				;now position
    state BYTE 0
    cusorPos COORDB <>				;position register
    planePos COORDB <25,41>
    pre_planePos COORDB <13,47>
	bulletPos COORDB <25,41>
	pre_bulletPos COORDB <25,41>
    enemy1Pos COORDB <15,10>
    pre_enemy1Pos COORDB <15,50>
    enemy2Pos COORDB <40,30>
    pre_enemy2Pos COORDB <40,30>
    enemy3Pos COORDB <60,27>
    pre_enemy3Pos COORDB <60,27>
	enemy4Pos COORDB <30,16>
    pre_enemy4Pos COORDB <30,16>
	bossPos COORDB <30,8>
	pre_bossPos COORDB <30,8>
	titlenamePos COORDB <85,6>
	titlename2Pos COORDB <85,9>
	hpPos COORDB <85,25>
	hplifePos COORDB <111,26>
	titlename BYTE  " __  .__   __. ___       ___    ___       ______	  ________   ______         _______ ", "0",
					"|  | |  \ |  | \  \     /  /   /   \     |  __  \  |   ____| |   _  \       /    ___|", "0",
					"|  | |   \|  |  \  \   /  /   /  ^  \    | |  \  | |  |__    |  |_)  |      (   (    ", "0"
	titlename2 BYTE	"|  | |  . `  |   \  \ /  /   /  /_\  \   | |   | | |   __|   |      /        \   \   ", "0",
					"|  | |  |\   |    \  V  /   /  _____  \  | |__/  | |  |____  |  |\  \__  .____)   )  ", "0",
					"|__| |__| \__|     \___/   /__/     \__\ |______/  |_______| | _| `.___| |_______/   ", "0"
	hp BYTE	" __    __  _______   ", "0",
			"|  |  |  | |   _  \  ", "0",
			"|  |__|  | |  |_)  |  ||", "0",
			"|   __   | |   ___/  ", "0",
			"|  |  |  | |  |       ||", "0",
			"|__|  |__| |__|      ", "0"
	hplife BYTE	"  __  ", "0",
				" /  \ ", "0",
				" |  | ", "0",
				" \__/ ", "0"
	winstring byte "Win", 0
	gameoverstring byte "Game over", 0
    BoxRow BYTE "111111111111111111111111111111111111111111111111111111111111111111111111"
    BoxCol1 BYTE "|                                                                			   |"
	hero BYTE  140, 143, 143, 143, 143, 140, "0",	;hero image
               194, " ", 203, " ", 209, "0"		
    enemy BYTE 153, "0",							;enemy image
		       154, "0"
	boss BYTE  186, 154, "    ", 154, "    ", 154, 186, "0",
	           182, 157, "  ", 201, 205, 143, 205, 201, "  ", 157, 199, "0",
		       186, 157, " ", 165, 186, " ", 142, " ", 186, 165, " ", 157, 186, "0",
	           200, 11 dup(205), 188, "0",
		       239, " ", 9 dup(210), " ", 239, "0"
	bullet BYTE " ", 94, " ", " ", 94, "0"
.code

PrintObj PROC, pos: COORDB, img: PTR DWORD, num: DWORD, color: DWORD
	push ecx
	mov bl, pos.x
	mov cusorPos.x, bl				;store coordinate		
	mov bl, pos.y
	mov cusorPos.y, bl				;store coordinate
	mov ecx, num					;times of print
	mov esi, img					;first place
	mov eax, color  
    call SetTextColor
	mov al, [esi]
	PRINTING:
		.IF al == 32 				;if blank, nothing 
									
		.ElSE		 		
			.IF al == 48 			;if 0, change line
				inc cusorPos.y  	;y++
				mov bl, pos.x   	
				mov cusorPos.x, bl	
				dec cusorPos.x		;x--
			.ElSE               	;not blank or 0, print
				mov dl, cusorPos.x
				mov dh, cusorPos.y
				call Gotoxy
				call WriteChar		;print character
			.ENDIF
		.ENDIF
		inc cusorPos.x     			;x++
		inc esi						;esi++
		mov al, [esi]
	LOOP PRINTING
	pop ecx
	ret 
PrintObj ENDP

PosAssign PROC, pos1x: ptr BYTE, pos1y: ptr BYTE, pos2x: ptr BYTE, pos2y: ptr BYTE
	mov esi, pos2x
	mov edi, pos1x
	mov bl, [esi]
	mov [edi], bl
						;store last position 2>1
	mov esi, pos2y
	mov edi, pos1y
	mov bl, [esi]
	mov [edi], bl
	ret
PosAssign ENDP

ClearPre PROC, pos: COORDB, img: PTR DWORD, num: DWORD
    push ecx	
	mov bl, pos.x
	mov cusorPos.x, bl				;store coordinate
	mov bl, pos.y
	mov cusorPos.y, bl				;store coordinate
	mov ecx, num
	mov esi, img
	mov al, [esi]
	CLEAR:
		.IF al == 32 				;if blank, nothing
			 		 			
		.ElSE		 			
			.IF al == 48 			;if 0, change line
				inc cusorPos.y  	;y++
				mov bl, pos.x   	
				mov cusorPos.x, bl	
				dec cusorPos.x		;x--
			.ElSE               
				mov dl, cusorPos.x
				mov dh, cusorPos.y
				call Gotoxy
				push eax
				mov al, 32
				call WriteChar		;print blank
				pop eax
			.ENDIF
		.ENDIF
		inc cusorPos.x     			;x++
		inc esi
		mov al, [esi]
	LOOP CLEAR
	pop ecx
	ret 
ClearPre ENDP

PrintBoxLine PROC, pos: COORDB, lines: PTR DWORD, num: DWORD
	push ecx
	mov dl, pos.x
	mov dh, pos.y
	call Gotoxy
	mov ecx, num
	mov esi, lines

	PrintLine:
		mov al, [esi]
		inc esi
		call WriteChar
		inc dl
		call Gotoxy
	loop PrintLine
	mov al, cl 
	call WriteChar
	pop ecx
	ret
PrintBoxLine ENDP

Collision PROC, hPos: COORDB, ePos: COORDB
	mov eax, 0
	mov bl, ePos.x    	;left 6
	sub bl, 6
	mov cl, ePos.x    	;right 1
	add cl, 1
	.IF hPos.x > bl
		.IF hPos.x < cl
			JMP Y
		.ENDIF
	.ENDIF
	ret
	Y:
		mov bl, ePos.y    ;up 2
		sub bl, 2
		mov cl, ePos.y    ;down 2
		add cl, 2
		.IF hPos.y > bl
			.IF hPos.y < cl
				mov eax, 1
				ret
			.ENDIF
		.ENDIF
	ret
Collision ENDP

Collision2 PROC, bPos: COORDB, hPos: COORDB
	mov eax, 0
	mov bl, hPos.x    	
	sub bl, 13
	mov cl, hPos.x    	
	add cl, 6
	.IF bPos.x > bl
		.IF bPos.x < cl
			JMP Y
		.ENDIF
	.ENDIF
	ret
	Y:
		mov cl, bPos.y    
		sub cl, 1
		mov bl, bPos.y
		add bl, 5
		.IF hPos.y > cl
			.IF hPos.y < bl
				mov eax, 1
				ret
			.ENDIF
		.ENDIF
	ret
Collision2 ENDP

Collision3 PROC, bPos: COORDB, buPos: COORDB
	mov eax, 0
	mov bl, buPos.x    	
	sub bl, 12
	mov cl, buPos.x    	
	add cl, 5
	.IF bPos.x > bl
		.IF bPos.x < cl
			JMP Y
		.ENDIF
	.ENDIF
	ret
	Y:
		mov cl, bPos.y    
		sub cl, 1
		mov bl, bPos.y
		add bl, 5
		.IF buPos.y > cl
			.IF buPos.y < bl
				mov eax, 1
				ret
			.ENDIF
		.ENDIF
	ret
Collision3 ENDP

main PROC
    invoke getstdhandle, std_output_handle
	mov outputhandle, eax
	call clrscr
L0:
	mov xyposition.y, 5
	mov ecx, 2
L1:
    push ecx
    invoke writeconsoleoutputattribute, outputhandle, addr attributes0, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	pop ecx
	loop L1
	mov ecx, 2
L2:
    push ecx
    invoke writeconsoleoutputattribute, outputhandle, addr attributes1, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	pop ecx
	loop L2
	mov ecx, 2
L3:
    push ecx
    invoke writeconsoleoutputattribute, outputhandle, addr attributes2, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	pop ecx
	loop L3
    mov ecx, 2
L4:
    push ecx
    invoke writeconsoleoutputattribute, outputhandle, addr attributes3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	pop ecx
	loop L4

    invoke writeconsoleoutputattribute, outputhandle, addr attributes4, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	mov ecx, 2
L5:
    push ecx
    invoke writeconsoleoutputattribute, outputhandle, addr attributes5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	pop ecx
	loop L5
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes6, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes7, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes8, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes9, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes10, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes11, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes12, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes13, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes14, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes15, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes16, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	mov ecx, 2
L6:
    push ecx
	invoke writeconsoleoutputattribute, outputhandle, addr attributes17, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	pop ecx
	loop L6
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes18, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes19, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes20, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes21, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes22, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes23, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes24, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes25, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes26, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes27, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes28, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes29, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes30, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes31, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes32, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten

    mov (coord ptr xyposition).y, 28
	invoke writeconsoleoutputattribute, outputhandle, addr attributes17, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line2,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes17, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line3,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes18, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line4,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes19, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line5,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes20, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line6,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes21, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line7,         56, xyposition, addr cellswritten

    invoke sleep, 200
	mov (coord ptr xyposition).y, 18
    invoke writeconsoleoutputattribute, outputhandle, addr attributes83, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes93, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes103, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes113, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes123, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes133, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes142, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes152, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y

	invoke sleep, 200
	mov (coord ptr xyposition).y, 16
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes62, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes72, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes82, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes92, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes102, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes112, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes122, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes132, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes142, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes152, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke sleep, 200
	mov (coord ptr xyposition).y, 16
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes6, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes7, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y

    invoke writeconsoleoutputattribute, outputhandle, addr attributes83, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes93, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes103, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes113, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes123, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes133, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes142, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes152, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,         56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke sleep, 200
	call readkey
	jz L0
    cmp dx, 20h
	jnz L0
L7:
    mov xyposition.y, 8
    invoke writeconsoleoutputattribute, outputhandle, addr space0, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	invoke sleep, 100
	
	invoke writeconsoleoutputattribute, outputhandle, addr space1, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	invoke sleep, 100
	
	invoke writeconsoleoutputattribute, outputhandle, addr space2, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	invoke sleep, 100
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes1, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	invoke sleep, 100
	
	invoke writeconsoleoutputattribute, outputhandle, addr space41, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space4, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	invoke sleep, 100
	
	mov xyposition.y, 9
	invoke writeconsoleoutputattribute, outputhandle, addr attributes2, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc xyposition.y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes2, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc xyposition.y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space6, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space7, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	invoke sleep, 100
	
	mov xyposition.y, 11
	invoke writeconsoleoutputattribute, outputhandle, addr attributes3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc xyposition.y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc xyposition.y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space8, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space9, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space10, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space11, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space12, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	invoke sleep, 100
	
	mov xyposition.y, 13
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes4, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr attributes5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space13, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space14, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space15, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space16, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space17, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space18, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space19, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space20, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space21, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,    56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	invoke sleep, 100

	mov xyposition.y, 13
	invoke writeconsoleoutputattribute, outputhandle, addr attributes4, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space22, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space221, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space23, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space24, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space25, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space26, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space27, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space28, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space29, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space30, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space31, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space32, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space33, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space34, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space341, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space35, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space36, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space37, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space38, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space39, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space40, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr space411, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,        56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	mov xyposition.y, 15
	
	invoke writeconsoleoutputattribute, outputhandle, addr last0, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last1, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last2, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last4, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last6, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last7, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last8, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last9, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last10, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last11, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last12, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last13, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last14, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last15, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last16, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last17, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last18, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last19, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last20, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last21, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	
	invoke sleep, 200
	
	mov xyposition.y, 15
	
	invoke writeconsoleoutputattribute, outputhandle, addr last2, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last1, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last1, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last12, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last18, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last9, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last2, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last11, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last19, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last13, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last21, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last20, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last16, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last11, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last12, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last18, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last15, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last14, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	
	invoke sleep, 100
	
	mov xyposition.y, 15
	
	invoke writeconsoleoutputattribute, outputhandle, addr last6, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last2, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last4, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last6, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last12, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last8, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last14, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last10, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last11, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last12, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last11, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last16, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last17, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last8, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last19, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last0, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr last21, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	
	invoke sleep, 100
	call clrscr
	
start:
	
	mov xyposition.y, 16
	invoke writeconsoleoutputattribute, outputhandle, addr start0, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start1, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start2, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start7, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start8, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start9, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start10, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start11, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start12, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start13, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start14, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr start15, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	invoke sleep, 200
	
	mov xyposition.y, 16
	invoke writeconsoleoutputattribute, outputhandle, addr starta0, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta1, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta2, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta7, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta8, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta9, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta10, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta11, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta12, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta13, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta14, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starta15, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	invoke sleep, 200
	
	mov xyposition.y, 16
	invoke writeconsoleoutputattribute, outputhandle, addr starts0, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts1, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts2, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts3, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts5, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts7, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts8, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts9, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts10, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts11, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts12, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts13, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts14, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	inc (coord ptr xyposition).y
	
	invoke writeconsoleoutputattribute, outputhandle, addr starts15, 112, xyposition, addr cellswritten
	invoke writeconsoleoutputcharacter, outputhandle, addr line,   56, xyposition, addr cellswritten
	invoke sleep, 200
	
	call clrscr
	mov ecx, 50
	mov xyPos.x, 8
	mov xyPos.y, 2
	mov planePos.x, 13
	mov planePos.y, 47
	mov bulletPos.x, 13
	mov bulletPos.y, 46
	mov hplifePos.x, 111
	mov eax, 14
	call SetTextColor
	PrintBox:						;print edge
		.IF ecx == 50 || ecx == 1
			INVOKE PrintBoxLine, xyPos, ADDR BoxRow, LENGTHOF BoxRow	
		.ElSE
			INVOKE PrintBoxLine, xyPos, ADDR BoxCol1, LENGTHOF BoxCol1
		.ENDIF
		inc xyPos.y
	Loop PrintBox
	INVOKE PrintObj, titlenamePos, ADDR titlename, LENGTHOF titlename, 11
	INVOKE PrintObj, titlename2Pos, ADDR titlename2, LENGTHOF titlename2, 11
	INVOKE PrintObj, hpPos, ADDR hp, LENGTHOF hp, 12
	INVOKE PrintObj, hplifePos, ADDR hplife, LENGTHOF hplife, 12
	mov ecx, 3
	PrintHp:
		INVOKE PrintObj, hplifePos, ADDR hplife, LENGTHOF hplife, 12
		add hplifePos.x, 7
	Loop PrintHp
	.WHILE 1
		push eax
		mov eax, 50
		call DELAY
		pop eax
		INVOKE ClearPre, pre_planePos, ADDR hero, LENGTHOF hero
		INVOKE PrintObj, planePos, ADDR hero, LENGTHOF hero, 15
		call ReadKey
		jz EnemyMoveandShoot		;input or not
		.IF ax == 1177h 	;up
			INVOKE PosAssign, addr pre_planePos.x, addr pre_planePos.y, addr planePos.x,  addr planePos.y
			sub planePos.y, 2
			.IF planePos.y < 3
				add planePos.y, 2
			.ENDIF
		.ELSEIF ax == 1f73h ;down
			INVOKE PosAssign, addr pre_planePos.x, addr pre_planePos.y, addr planePos.x,  addr planePos.y
			add planePos.y, 2
			.IF planePos.y > 50
				sub planePos.y, 2
			.ENDIF
		.ELSEIF ax == 2064h ;RIGHT
			INVOKE PosAssign, addr pre_planePos.x, addr pre_planePos.y, addr planePos.x,  addr planePos.y
			add planePos.x, 4
			.IF planePos.x > 76
				sub planePos.x, 4
			.ENDIF
		.ELSEIF ax == 1e61h ;LEFT
			INVOKE PosAssign, addr pre_planePos.x, addr pre_planePos.y, addr planePos.x,  addr planePos.y
			sub planePos.x, 4
			.IF planePos.x < 9
				add planePos.x, 4
			.ENDIF
		.ENDIF
		INVOKE ClearPre, pre_planePos, ADDR hero, LENGTHOF hero
		INVOKE PrintObj, planePos, ADDR hero, LENGTHOF hero, 15
		EnemyMoveandShoot:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;boss;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov eax, 2
		call RandomRange
		.IF ax == 0
			INVOKE PosAssign, addr pre_bossPos.x, addr pre_bossPos.y, addr bossPos.x, addr bossPos.y
			add bossPos.x, 4

			.IF bossPos.x > 65
				sub bossPos.x, 4
			.ENDIF
		.ENDIF
		.IF ax == 1
			INVOKE PosAssign, addr pre_bossPos.x, addr pre_bossPos.y, addr bossPos.x,  addr bossPos.y
			sub bossPos.x, 4

			.IF bossPos.x < 9
				add bossPos.x, 4
			.ENDIF
		.ENDIF
		INVOKE ClearPre, pre_bossPos, ADDR boss, LENGTHOF boss
		INVOKE PrintObj, bossPos, ADDR boss, LENGTHOF boss, 4
		INVOKE PrintObj, enemy1Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy2Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy3Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy4Pos, ADDR enemy, LENGTHOF enemy, 5
		mov eax, 10
		call DELAY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;bullet;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		INVOKE PosAssign, addr pre_bulletPos.x, addr pre_bulletPos.y, addr bulletPos.x, addr bulletPos.y
		INVOKE ClearPre, pre_bulletPos, ADDR bullet, LENGTHOF bullet
		INVOKE PrintObj, bulletPos, ADDR bullet, LENGTHOF bullet, 14
		INVOKE Collision3, bossPos, bulletPos
		mov bl, bulletPos.x
		mov cl, bulletPos.y
		.IF eax == 1
			sub hplifePos.x, 7
			INVOKE ClearPre, hplifePos, ADDR hplife, LENGTHOF hplife
			mov dl, hplifePos.x
			.IF dl == 111
				jmp WIN
			.ENDIF
			INVOKE PosAssign, addr pre_bulletPos.x, addr pre_bulletPos.y, addr bulletPos.x, addr bulletPos.y
			INVOKE ClearPre, pre_bulletPos, ADDR bullet, LENGTHOF bullet
			INVOKE PosAssign, addr bulletPos.x, addr bulletPos.y, addr planePos.x, addr planePos.y
			INVOKE PrintObj, bulletPos, ADDR bullet, LENGTHOF bullet, 14
		.ELSEIF cl == 4
			INVOKE PosAssign, addr pre_bulletPos.x, addr pre_bulletPos.y, addr bulletPos.x, addr bulletPos.y
			INVOKE ClearPre, pre_bulletPos, ADDR bullet, LENGTHOF bullet
			INVOKE PosAssign, addr bulletPos.x, addr bulletPos.y, addr planePos.x, addr planePos.y
			INVOKE PrintObj, bulletPos, ADDR bullet, LENGTHOF bullet, 14
		.ELSE 
			INVOKE PosAssign, addr pre_bulletPos.x, addr pre_bulletPos.y, addr bulletPos.x, addr bulletPos.y
			sub bulletPos.y, 1
			INVOKE ClearPre, pre_bulletPos, ADDR bullet, LENGTHOF bullet
			INVOKE PrintObj, bulletPos, ADDR bullet, LENGTHOF bullet, 14
		.ENDIF
		mov eax, 5
		call DELAY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov eax, 4
		call RandomRange
		.IF ax == 0
			INVOKE PosAssign, addr pre_enemy1Pos.x, addr pre_enemy1Pos.y, addr enemy1Pos.x,  addr enemy1Pos.y
			sub enemy1Pos.y, 2
			.IF enemy1Pos.y < 3
				add enemy1Pos.y, 2
			.ENDIF
		.ENDIF
		.IF ax == 1
			INVOKE PosAssign, addr pre_enemy1Pos.x, addr pre_enemy1Pos.y, addr enemy1Pos.x,  addr enemy1Pos.y
			add enemy1Pos.y, 2

			.IF enemy1Pos.y > 48
				sub enemy1Pos.y, 2
			.ENDIF
		.ENDIF
		.IF ax == 2
			INVOKE PosAssign, addr pre_enemy1Pos.x, addr pre_enemy1Pos.y, addr enemy1Pos.x,  addr enemy1Pos.y
			add enemy1Pos.x, 3

			.IF enemy1Pos.x > 76
				sub enemy1Pos.x, 3
			.ENDIF
		.ENDIF
		.IF ax == 3
			INVOKE PosAssign, addr pre_enemy1Pos.x, addr pre_enemy1Pos.y, addr enemy1Pos.x,  addr enemy1Pos.y
			sub enemy1Pos.x, 3

			.IF enemy1Pos.x < 11
				add enemy1Pos.x, 3
			.ENDIF
		.ENDIF
		INVOKE ClearPre, pre_enemy1Pos, ADDR enemy, LENGTHOF enemy
		INVOKE PrintObj, enemy1Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy2Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy3Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy4Pos, ADDR enemy, LENGTHOF enemy, 5
		mov eax, 10
		call DELAY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov eax, 4
		call RandomRange
		.IF ax == 0
			INVOKE PosAssign, addr pre_enemy2Pos.x, addr pre_enemy2Pos.y, addr enemy2Pos.x,  addr enemy2Pos.y
			sub enemy2Pos.y, 2
			.IF enemy2Pos.y < 3
				add enemy2Pos.y, 2
			.ENDIF
		.ENDIF
		.IF ax == 1
			INVOKE PosAssign, addr pre_enemy2Pos.x, addr pre_enemy2Pos.y, addr enemy2Pos.x,  addr enemy2Pos.y
			add enemy2Pos.y, 2

			.IF enemy2Pos.y > 48
				sub enemy2Pos.y, 2
			.ENDIF
		.ENDIF
		.IF ax == 2
			INVOKE PosAssign, addr pre_enemy2Pos.x, addr pre_enemy2Pos.y, addr enemy2Pos.x,  addr enemy2Pos.y
			add enemy2Pos.x, 2

			.IF enemy2Pos.x > 76
				sub enemy2Pos.x, 2
			.ENDIF
		.ENDIF
		.IF ax == 3
			INVOKE PosAssign, addr pre_enemy2Pos.x, addr pre_enemy2Pos.y, addr enemy2Pos.x,  addr enemy2Pos.y
			sub enemy2Pos.x, 2

			.IF enemy2Pos.x < 11
				add enemy2Pos.x, 2
			.ENDIF
		.ENDIF
		INVOKE ClearPre, pre_enemy2Pos, ADDR enemy, LENGTHOF enemy
		INVOKE PrintObj, enemy1Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy2Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy3Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy4Pos, ADDR enemy, LENGTHOF enemy, 5
		mov eax, 10
		call DELAY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;3;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov eax, 4
		call RandomRange
		.IF ax == 0
			INVOKE PosAssign, addr pre_enemy3Pos.x, addr pre_enemy3Pos.y, addr enemy3Pos.x,  addr enemy3Pos.y
			sub enemy3Pos.y, 1
			.IF enemy3Pos.y < 3
				add enemy3Pos.y, 1
			.ENDIF
		.ENDIF
		.IF ax == 1
			INVOKE PosAssign, addr pre_enemy3Pos.x, addr pre_enemy3Pos.y, addr enemy3Pos.x,  addr enemy3Pos.y
			add enemy3Pos.y, 1

			.IF enemy3Pos.y > 48
				sub enemy3Pos.y, 1
			.ENDIF
		.ENDIF
		.IF ax == 2
			INVOKE PosAssign, addr pre_enemy3Pos.x, addr pre_enemy3Pos.y, addr enemy3Pos.x,  addr enemy3Pos.y
			add enemy3Pos.x, 1

			.IF enemy3Pos.x > 76
				sub enemy3Pos.x, 1
			.ENDIF
		.ENDIF
		.IF ax == 3
			INVOKE PosAssign, addr pre_enemy3Pos.x, addr pre_enemy3Pos.y, addr enemy3Pos.x,  addr enemy3Pos.y
			sub enemy3Pos.x, 1

			.IF enemy3Pos.x < 11
				add enemy3Pos.x, 1
			.ENDIF
		.ENDIF
		INVOKE ClearPre, pre_enemy3Pos, ADDR enemy, LENGTHOF enemy
		INVOKE PrintObj, enemy1Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy2Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy3Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy4Pos, ADDR enemy, LENGTHOF enemy, 5
		mov eax, 10
		call DELAY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;4;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov eax, 4
		call RandomRange
		mov bl, planePos.y
		add bl, 2
		.IF enemy4Pos.y > bl
			INVOKE PosAssign, addr pre_enemy4Pos.x, addr pre_enemy4Pos.y, addr enemy4Pos.x,  addr enemy4Pos.y
			sub enemy4Pos.y, 1
			.IF enemy4Pos.y < 3
				add enemy4Pos.y, 1
			.ENDIF
		.ENDIF
		INVOKE ClearPre, pre_enemy4Pos, ADDR enemy, LENGTHOF enemy
		INVOKE PrintObj, enemy1Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy2Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy3Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy4Pos, ADDR enemy, LENGTHOF enemy, 5
		mov bl, planePos.y
		sub bl, 2
		.IF enemy4Pos.y < bl
			INVOKE PosAssign, addr pre_enemy4Pos.x, addr pre_enemy4Pos.y, addr enemy4Pos.x,  addr enemy4Pos.y
			add enemy4Pos.y, 1
			.IF enemy4Pos.y > 47
				sub enemy4Pos.y, 1
			.ENDIF
		.ENDIF
		INVOKE ClearPre, pre_enemy4Pos, ADDR enemy, LENGTHOF enemy
		INVOKE PrintObj, enemy1Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy2Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy3Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy4Pos, ADDR enemy, LENGTHOF enemy, 5
		mov dl, planePos.x
		.IF enemy4Pos.x < dl
			INVOKE PosAssign, addr pre_enemy4Pos.x, addr pre_enemy4Pos.y, addr enemy4Pos.x,  addr enemy4Pos.y
			add enemy4Pos.x, 1
			.IF enemy4Pos.x > 76
				sub enemy4Pos.x, 1
			.ENDIF
		.ENDIF
		INVOKE ClearPre, pre_enemy4Pos, ADDR enemy, LENGTHOF enemy
		INVOKE PrintObj, enemy1Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy2Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy3Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy4Pos, ADDR enemy, LENGTHOF enemy, 5
		mov dl, planePos.x
		.IF enemy4Pos.x > dl
			INVOKE PosAssign, addr pre_enemy4Pos.x, addr pre_enemy4Pos.y, addr enemy4Pos.x,  addr enemy4Pos.y
			sub enemy4Pos.x, 1
			.IF enemy4Pos.x < 11
				add enemy4Pos.x, 1
			.ENDIF
		.ENDIF
		INVOKE ClearPre, pre_enemy4Pos, ADDR enemy, LENGTHOF enemy
		INVOKE PrintObj, enemy1Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy2Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy3Pos, ADDR enemy, LENGTHOF enemy, 2
		INVOKE PrintObj, enemy4Pos, ADDR enemy, LENGTHOF enemy, 5
		mov eax, 15
		call DELAY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov edx, 0
		INVOKE Collision, planePos, enemy1Pos
		add edx, eax
		INVOKE Collision, planePos, enemy2Pos
		add edx, eax
		INVOKE Collision, planePos, enemy3Pos
		add edx, eax
		INVOKE Collision, planePos, enemy4Pos
		add edx, eax
		INVOKE Collision2, bossPos, planePos
		add edx, eax
		
		mov eax, edx
		.IF eax > 0
		    mov enemy4Pos.x, 30
			mov enemy4Pos.y, 16
			JMP GAMEOVER
		.ENDIF
	.ENDW
	
	WIN:
		call clrscr
		mov edx, offset winstring
		call writestring
		call crlf
		jmp L0
	GAMEOVER:
	    call clrscr
		mov edx, offset gameoverstring
		call writestring
		call crlf
		jmp L0
	exit
main ENDP

END main