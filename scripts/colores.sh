#!/bin/sh

case "$1" in 
  1)
    echo -e "
\033[0;30m██████ \033[0;31m██████ \033[0;32m██████ \033[0;33m██████ \033[0;34m██████ \033[0;35m██████ \033[0;36m██████ \033[0;37m██████

\033[1;30m██████ \033[1;31m██████ \033[1;32m██████ \033[1;33m██████ \033[1;34m██████ \033[1;35m██████ \033[1;36m██████ \033[1;37m██████

";;

  2)
    echo -e "
\033[0;30m██ \033[0;31m██ \033[0;32m██ \033[0;33m██ \033[0;34m██ \033[0;35m██ \033[0;36m██ \033[0;37m██
\033[0;30m██ \033[0;31m██ \033[0;32m██ \033[0;33m██ \033[0;34m██ \033[0;35m██ \033[0;36m██ \033[0;37m██
\033[1;30m██ \033[1;31m██ \033[1;32m██ \033[1;33m██ \033[1;34m██ \033[1;35m██ \033[1;36m██ \033[1;37m██
\033[1;30m██ \033[1;31m██ \033[1;32m██ \033[1;33m██ \033[1;34m██ \033[1;35m██ \033[1;36m██ \033[1;37m██
";;

  3)
    echo -e "
 \033[0;30m               #\033[1;30m#       
 \033[0;30m              ##\033[1;30m##    
 \033[0;31m             ###\033[1;31m###    
 \033[0;31m            ####\033[1;31m####    
 \033[0;32m           #####\033[1;32m#####   
 \033[0;32m          ######\033[1;32m######   
 \033[0;33m         #######\033[1;33m#######   
 \033[0;33m        ########\033[1;33m########               
 \033[0;34m       #########\033[1;34m#########        
 \033[0;34m      ########    \033[1;34m########        
 \033[0;35m     ########      \033[1;35m########       
 \033[0;35m    #########      \033[1;35m#########      
 \033[0;36m   ##########      \033[1;36m##########     
 \033[0;36m  ########            \033[1;36m########    
 \033[0;37m #####                    \033[1;37m#####   
 \033[0;37m###                          \033[1;37m###  
";;
esac
