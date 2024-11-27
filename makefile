default:
	../rgbds-0.8.0/rgbasm -o main.o main.s
	../rgbds-0.8.0/rgblink -o main.gb main.o
	../rgbds-0.8.0/rgbfix -v -p 0xFF main.gb
	rm *.o
