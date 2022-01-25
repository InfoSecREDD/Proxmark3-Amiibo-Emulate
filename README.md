# Proxmark3-Amiibo-Emulate
This Bash Script automatically emulates the Amiibo tag 
using any Bash terminal and Proxmark3. Such as - Termux
(using BT(or USB)-TCP Bridge method), Kali Linux, Ubuntu,
etc..

Syntax:

amiibo.sh (Current under review - Does not work.)

``bash amiibo.sh </path/to/bin/file>``

amiibo-eml.sh

``bash amiibo-eml.sh </path/to/bin/file.bin> <filename.eml>``

or

``bash amiibo-eml.sh </path/to/eml/file.eml>``

To use TCP BL-UART or TCP USB-UART make sure to set 
"USE_TCP_BRIDGE" to "1".

To use normal /dev/ttyACM0 make sure to set "USE_TCP_BRIDGE"
to "0".

(Make sure to view the file and edit the variables accordingly to your system
)

# How-to Download the Script:
Easy Method: (from bash terminal)

``wget https://raw.githubusercontent.com/InfoSecREDD/Proxmark3-Amiibo-Emulate/main/amiibo-eml.sh -O amiibo-eml.sh | chmod +x amiibo-eml.sh``


Other Methods:
Copy and paste the code from this repo using git clone or
viewing the source itself.

