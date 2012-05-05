#----------------------------------
# Mote:    Autostart
# Archivo: ~/.config/wmfs/start.sh
# Fecha:   05-05-2012
#!/bin/bash
#----------------------------------

#-------------------------------------
# Encanalada de conqui al estatusbar.
#-------------------------------------
conky -c ~/.conkyrc | while true; read line; do wmfs -c status "default $line"; done &

#-----------------------------
# Inicio Nitrogen(wallpapers)
#-----------------------------
nitrogen --restore &

#-------------------
# Seteo del teclado
#-------------------
setxkbmap es

##-----------------
# Activar BloqNum
#-----------------
numlockx &
