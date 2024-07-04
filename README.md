# IP Adapt
This bash script replaces a **single** IP in the `allow <IP>` line of a nginx config.  
The intention was, to whitelist quick and easy my IP for a specific http route.  

*Note:* this script performs a backup of the target file, via `sed -i.bak`.  

## bashrc
I added for convenience an alias to my .bashrc, so it reloads nginx after the replace.  
`alias ipadapt='sudo /YourPath>/ipadapt.sh && sudo nginx -s reload'`  

