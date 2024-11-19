#Creamos los discos de 1G y de 2G

#1)Acceder al disco de 1gb para particionar: 
sudo fdisk /dev/sdc 

# !  Particionar como indica el ejercicio (5M): 
# !  add a new partition=

#a. Elejimos la opcion para particionar (n).
n
#b. Lo hacemos primario (p).
p
#c. El numero de la particion sera el predeterminado (Seleccionamos Enter o 1).
Enter
#d. En first sector el valor sera predeterminado (Enter o 2048).
Enter
#e. En last sector elegimos la cantidad de espacio que tendra la participacion (+5M).
+5M
#f. Cambiamos el tipo de particion (t).
t
#g. Y la cambiamos a tipo de particion LVM Linux introduciendo el codigo 8e.
8e
# Guardamos los cambios. 
wq 

# ! Se convierte la partición a volumen físico: 
sudo pvcreate /dev/sdc1

# ! Creamos el grupo de volúmenes “VG” (vg_datos): 
sudo vgcreate vg_datos /dev/sdc1

#2)Accedemos al disco de 2gb para particionar:
sudo fdisk /dev/sdd

# !  Particionar como indica el ejercicio (1.5G):
# !  add a new partition=

#a. Elejimos la opcion para particionar (n).
n
#b. Lo hacemos primario (p).
p
#c. El numero de la particion sera el predeterminado (Seleccionamos Enter o 1).
Enter
#d. En first sector el valor sera predeterminado (Enter o 2048).
Enter
#e. En last sector elegimos la cantidad de espacio que tendra la participacion (+1.5G).
+1.5G
#f. Cambiamos el tipo de particion (t).
t
#g. Y la cambiamos a tipo de particion LVM Linux introduciendo el codigo 8e.
8e
# Guardamos los cambios.
wq


# ! Luego volvemos a convertir a volumen fisico: 
sudo pvcreate /dev/sdd1

# ! Lo añadimos al grupo de volumenes VG: 
sudo vgextend vg_datos /dev/sdd1

#3) Accedemos al disco de 2gb para particionar: 
sudo fdisk /dev/sdd

# !  Particionar como indica el ejercicio (1.5G):
# !  add a new partition=

#a. Elejimos la opcion para particionar (n).
n
#b. Lo hacemos primario (p).
p
#c. El numero de la particion sera el predeterminado (Seleccionamos Enter o 1).
Enter
#d. En first sector el valor sera predeterminado (Enter o 2048).
Enter
#e. En last sector elegimos la cantidad de espacio que tendra la participacion (+1.5G).
Enter
#f. Cambiamos el tipo de particion (t).
t
2
#g. Y la cambiamos a tipo de particion LVM Linux introduciendo el codigo 8e.
8e
# Guardamos los cambios.
wq


# ! Luego volvemos a convertir a volumen fisico: 
sudo pvcreate /dev/sdd2

# ! Creamos el grupo de volumenes (VG): 
sudo vgcreate vg_temp /dev/sdd2

#4) Creamos el volumen logico de lv_docker “LV”: 
sudo lvcreate -L +4M vg_datos -n lv_docker

#5) Creamos el volumen logico de lv_workareas: 
sudo lvcreate -l +100%FREE vg_datos -n lv_workareas 

#6) Creamos el volumen logico de lv_swap: 
sudo lvcreate -l +100%FREE vg_temp -n lv_swap

#7) Formateamos las particiones:
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
sudo mkswap /dev/vg_temp/lv_swap

#8) Montamos las particiones:
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker
sudo mount /dev/mapper/vg_datos-lv_workareas /work/
sudo swapon /dev/vg_temp/lv_swap

