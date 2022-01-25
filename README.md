# Proxmark3-Amiibo-Emulate
This Bash Script automatically emulates the Amiibo tag 
using any Bash terminal. Such as - Termux (using BT(or 
USB)-TCP Bridge method), Kali Linux, Ubuntu, etc..

Syntax:
``bash amiibo.sh </path/to/bin/file>``

To use TCP BL-UART or TCP USB-UART make sure to set 
"USE_TCP_BRIDGE" to "1".

To use normal /dev/ttyACM0 make sure to set "USE_TCP_BRIDGE"
to "0".
