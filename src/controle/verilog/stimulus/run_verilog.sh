#!/bin/bash

set -e

TOP=src_top
BUILD_DIR=build

#Auto-clean build
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}

verilator \
	--cc \
	--exe \
	--build \
	--trace \
	-Wall \
	--Mdir ${BUILD_DIR} \
	--x-assign unique \
	--x-initial unique \
	--top-module ${TOP} \
	-Irtl \
	../src_top.v \
	../main_decoder.v \
	../alu_decoder.v \
	testbench_stim.cpp \
	-o sim_${TOP} \

echo "			SIMULATION...			"

./${BUILD_DIR}/sim_${TOP}

echo  "		FINISHED			"
