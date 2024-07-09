# IP Adapt
This bash script replaces a **single** IP in the `allow <IP>` line of a nginx config,
and reloads nginx after that.  
The intention was, to whitelist quick and easy my IP for a specific http route.  

## Usage
`./ipadapt.sh [-d]`  

If the argument `-d` is passed, it will comment the `allow <IP>` line.  
If the argument is omitted, it will replace the old IP, with your current IP,
and it will remove the comment.  

The idea behind that argument is, that it can "remove" the `allow` entry via a cronjob.  

## Backup
Before any editing, it will perform a backup of the file, as `<file>.bak`.  

