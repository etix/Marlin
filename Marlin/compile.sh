#!/bin/bash

if [ -z "$ARDUINO_PATH" ]; then
    echo "Please set the ARDUINO_PATH environment variable"
    exit 1
fi

AVR_TOOLS="${ARDUINO_PATH}/hardware/tools/avr/bin/"
export PATH="${AVR_TOOLS}:$PATH"

COMMON_PARAMS="HARDWARE_MOTHERBOARD=72 ARDUINO_INSTALL_DIR=${ARDUINO_PATH} ARDUINO_VERSION=106 AVR_TOOLS_PATH=${AVR_TOOLS_PATH}"

mkdir build

make ${COMMON_PARAMS} BUILD_DIR=build/UltimakerMarlin_250000 DEFINES="'VERSION_PROFILE=\"250000_single\"' BAUDRATE=250000 TEMP_SENSOR_1=0 EXTRUDERS=1"
make ${COMMON_PARAMS} BUILD_DIR=build/UltimakerMarlin_115200 DEFINES="'VERSION_PROFILE=\"115200_single\"' BAUDRATE=115200 TEMP_SENSOR_1=0 EXTRUDERS=1"
make ${COMMON_PARAMS} BUILD_DIR=build/UltimakerMarlin_Dual_250000 DEFINES="'VERSION_PROFILE=\"250000_dual\"' BAUDRATE=250000 TEMP_SENSOR_1=20 EXTRUDERS=2"
make ${COMMON_PARAMS} BUILD_DIR=build/UltimakerMarlin_Dual_115200 DEFINES="'VERSION_PROFILE=\"115200_dual\"' BAUDRATE=115200 TEMP_SENSOR_1=20 EXTRUDERS=2"

cp build/UltimakerMarlin_250000/Marlin.hex build/MarlinUltimaker-UMOP-250000.hex
cp build/UltimakerMarlin_115200/Marlin.hex build/MarlinUltimaker-UMOP-115200.hex
cp build/UltimakerMarlin_Dual_250000/Marlin.hex build/MarlinUltimaker-UMOP-250000-dual.hex
cp build/UltimakerMarlin_Dual_115200/Marlin.hex build/MarlinUltimaker-UMOP-115200-dual.hex
