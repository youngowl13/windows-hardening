# windows-hardening
Script to harden windows security
The Script does the following:
1) Disables Administrative shares
2) Extracts IP address and MAC address of the device and saves Output in C Drive
3) Updates the Audit policy for success and failure of all events & saves the updated policy in C Drive
4) Displays scheduled tasks for windows & saves the output in C Drive

Creates 3 more separate scripts with the following names and functionalities:
1) Block_All_Ports: Blocks all incoming connections and allows only outgoing connections
2) Disable_ICMP: Blocks ICMP requests to the host
3) Enable_ICMP: Enables ICMP requests to the host
