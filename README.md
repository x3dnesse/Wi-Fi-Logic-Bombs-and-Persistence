This repository includes some example PowerShell payloads for infected/compromised Windows hosts.

The premise behind these proof-of-concept scripts being effective is the following:

1. First, the client must be compromised through some form of shell, bind or reverse, etcetera 
2. Then, a secondary payload must be transferred to the client so that when they connect to the denoted wireless network, the new shell will run and connect back to the attacker through the public internet.
3. Alternatively, this can be combined into an exec command msfvenom payload, and the client will handle the rest.

These scripts are to be used for educational purposes only. The usage of these tools for attacking infrastructures without prior mutual consent could be considered an illegal activity and is highly discouraged by its authors/developers. It is the end user's responsibility to obey all applicable local, state and federal laws. Authors assume no liability and are not responsible for any misuse or damage caused by this program.