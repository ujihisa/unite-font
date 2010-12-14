
.PHONY: all clean

%.exe : %.cpp
	g++-3 $< -W -Wall -mno-cygwin -lgdi32 -o $@

all: fontinfo.exe

clean:
	rm -f *.exe

