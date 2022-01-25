#!/bin/bash
#
#  Title: Amiibo Convert & Emulate Bash Script for Proxmark3
#  Author: InfoSecREDD
#
#  SYNTAX: amiibo.sh <amiibo_bin_file> <output_eml_file>
#          amiibo.sh <amiibo_eml_file>


AMIIBO="${1}"
EML_FILE="${2}"

DUMP_DIR="${HOME}/dumps"
PROXMARK_DIR="${HOME}/proxmark3"

CLIENT="${PROXMARK_DIR}/client/proxmark3"
CONVERT="${PROXMARK_DIR}/tools/pm3_amii_bin2eml.pl"

USE_TCP_BRIDGE="1"

PORT="4321"
TCP="tcp:localhost:${PORT}"

if [ ! -f "${AMIIBO}" ]; then
        echo "There is no file by that name. Try again."
        exit 1
fi

if [[ "${AMIIBO}" == *.eml ]]; then
        TEMPVAR1="${DUMP_DIR}/${AMIIBO}"
        EML_FILE="${AMIIBO}"
        TEMPVAR2="${TEMPVAR1}"
        AMIIBO="${TEMPVAR2}"
        echo "Using supplied Amiibo eml file."
elif [[ ! -f "${DUMP_DIR}/${EML_FILE}" ]]; then
        ${CONVERT} "${AMIIBO}" > "${DUMP_DIR}/${EML_FILE}"
else
        echo "Converted Amiibo file found."
fi
if [ "${USE_TCP_BRIDGE}" -eq "1" ]; then
        ${CLIENT} ${TCP} -c "hf mf eclr"
        ${CLIENT} ${TCP} -c "hf mfu eload -f ${DUMP_DIR}/${EML_FILE} --ul"
        ${CLIENT} ${TCP} -c "hf 14a sim -t 7"
elif [ "${USE_TCP_BRIDGE}" -eq "0" ]; then
        ${CLIENT} -c "hf mf eclr"
        ${CLIENT} -c "hf mfu eload -f ${DUMP_DIR}/${EML_FILE} --ul"
        ${CLIENT} -c "hf 14a sim -t 7"
else
        echo "Error: Set correct value for Variables."
fi
