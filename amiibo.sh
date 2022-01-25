#!/bin/bash
#
#  Title: Amiibo Emulate Bash Script for Proxmark3
#  Author: InfoSecREDD
#
#  SYNTAX: bash amiibo.sh <amiibo_bin_file>
#


AMIIBO="${1}"

DUMP_DIR="${HOME}/dumps"
PROXMARK_DIR="${HOME}/proxmark3"

CLIENT="${PROXMARK_DIR}/client/proxmark3"

USE_TCP_BRIDGE="1"

PORT="4321"
TCP="tcp:localhost:${PORT}"

if ([ ! -f "${AMIIBO}" ]); then
        echo "There is no file by that name. Try again."
        exit 1
fi
if [ "${AMIIBO: -4}" == ".bin" ]; then
        echo "Valid bin file found."
        EMULATE_FILE="${DUMP_DIR}/amiibo.bin"
        if [ -f "${EMULATE_FILE}" ]; then
                rm -rf "${EMULATE_FILE}"
        fi
        cp -rf "${AMIIBO}" "${EMULATE_FILE}"
else
        echo "Error: Please provide a valid file to emulate."
fi
if [ "${USE_TCP_BRIDGE}" -eq "1" ]; then
        ${CLIENT} ${TCP} -c "hf mf eclr"
        ${CLIENT} ${TCP} -c "hf mfu eload -f ${EMULATE_FILE} --ul"
        ${CLIENT} ${TCP} -c "hf 14a sim -t 7"
elif [ "${USE_TCP_BRIDGE}" -eq "0" ]; then
        ${CLIENT} -c "hf mf eclr"
        ${CLIENT} -c "hf mfu eload -f ${EMULATE_FILE} --ul"
        ${CLIENT} -c "hf 14a sim -t 7"
else
        echo "Error: Set correct value for Variables."
fi
if [ -f "${EMULATE_FILE}" ]; then                                         
        echo "Cleaning up after emulation."
        rm -rf "${EMULATE_FILE}"
fi
echo "Done."
exit 0
