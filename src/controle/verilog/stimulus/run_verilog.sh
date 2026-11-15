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
	--trace-fst \
	-Wall \
	--x-assign unique \
	--x-initial unique \
	--top-module ${TOP} \
	-Irtl \
	-I../src_top.v \
	../main_decoder.v \
	../alu_decoder.v \
	-o sim_${TOP} \
	--Mdir ${BUILD_DIR}

echo "			SIMULATION...			"

./${BUILD_DIR}/sim_${TOP}

echo  "		FINISHED			"
