#!/bin/bash
#
#  Title: Amiibo Convert & Emulate Bash Script for Proxmark3
#  Author: InfoSecREDD
#
#  SYNTAX: bash amiibo-eml.sh </path/to/bin/file.bin>


AMIIBO="${1}"

DUMP_DIR="${HOME}/dumps/amiibo_eml"
PROXMARK_DIR="${HOME}/proxmark3"

CLIENT="${PROXMARK_DIR}/client/proxmark3"
CONVERT="${PROXMARK_DIR}/tools/pm3_amii_bin2eml.pl"

USE_TCP_BRIDGE="1"

PORT="4321"
TCP="tcp:localhost:${PORT}"

if [ ! -d "${DUMP_DIR}" ]; then
        mkdir -p "${DUMP_DIR}"
fi
if [ ! -f "${AMIIBO}" ]; then
        echo "There is no file by that name. Try again."
        exit 1
fi

if [ "${AMIIBO: -4}" == ".bin" ]; then
        EMULATE_FILE="${DUMP_DIR}/amiibo.eml"
        AMIIBO_COPY="${DUMP_DIR}/amiibo.bin"
        if [ -f "${EMULATE_FILE}" ]; then
                rm -rf "${EMULATE_FILE}"
        fi
        cp -rf "${AMIIBO}" "${AMIIBO_COPY}"
        ${CONVERT} "${AMIIBO_COPY}" > "${EMULATE_FILE}"
        if [ -f "${AMIIBO_COPY}" ]; then
                rm -rf "${AMIIBO_COPY}"
        fi
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
