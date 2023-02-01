CC = g++
OPTIMIZATION ?= -O2
WARNINGS = -Wno-missing-field-initializers
DEBUG ?= -g -ggdb
INCLUDE = -Iinclude/fmodex
REAL_CFLAGS = $(OPTIMIZATION) -fPIC $(CFLAGS) $(WARNINGS) $(DEBUG) $(INCLUDE)
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

build:  build/dir build/WaveEncoder.o build/File.o build/O2Jam/Music.o \
	build/O2Jam/MusicRenderer.o build/O2Jam/OJM.o build/O2Jam/OJN.o \
	build/IO.o build/RenderOJN.o
	$(CC) build/WaveEncoder.o build/File.o build/O2Jam/Music.o \
		build/O2Jam/MusicRenderer.o build/O2Jam/OJM.o build/O2Jam/OJN.o \
		build/IO.o build/RenderOJN.o lib/fmodex/linux64/libfmodex64.so \
		-lboost_program_options -lboost_date_time -ltag -lmp3lame -lsndfile \
		-o bin/RenderOJN

build/dir:
	@mkdir -p bin build build/O2Jam

build/WaveEncoder.o: src/Nx/Audio/WaveEncoder.cpp src/Nx/Audio/WaveEncoder.hpp
	$(CC) -c $(REAL_CFLAGS) $< -o $@

build/File.o: src/Nx/IO/File.cpp src/Nx/IO/File.hpp
	$(CC) -c $(REAL_CFLAGS) $< -o $@

build/O2Jam/Music.o: src/Nx/O2Jam/Music.cpp src/Nx/O2Jam/Music.hpp
	$(CC) -c $(REAL_CFLAGS) $< -o $@

build/O2Jam/MusicRenderer.o: src/Nx/O2Jam/MusicRenderer.cpp src/Nx/O2Jam/MusicRenderer.hpp
	$(CC) -c $(REAL_CFLAGS) $< -o $@

build/O2Jam/OJM.o: src/Nx/O2Jam/OJM.cpp src/Nx/O2Jam/OJM.hpp
	$(CC) -c $(REAL_CFLAGS) $< -o $@

build/O2Jam/OJN.o: src/Nx/O2Jam/OJN.cpp src/Nx/O2Jam/OJN.hpp
	$(CC) -c $(REAL_CFLAGS) $< -o $@

build/IO.o: src/Nx/IO.cpp src/Nx/IO.hpp
	$(CC) -c $(REAL_CFLAGS) $< -o $@

build/RenderOJN.o: src/RenderOJN.cpp
	$(CC) -c $(REAL_CFLAGS) $< -o $@

install:
	cp -v lib/fmodex/linux64/libfmodex64.so ~/.local/lib/ && \
		cp -v bin/RenderOJN ~/.local/bin/RenderOJN

clean:
	@rm -rfv build bin

.PHONY: build
