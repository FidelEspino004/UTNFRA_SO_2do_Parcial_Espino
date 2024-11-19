# ! Trabajamos dentro de la carpeta:
UTNFRA_SO_2do_Parcial_Chavarri/202406/ansible/

#1) Creamos la siguiente estructura de directorios:
mkdir -p /tmp/2do_parcial/alumnos /temp/2do_parcial/equipo

#2) Usando el módulo de templates, generamos 2 archivos:
/tmp/2do_parcial/alumno/datos_alumno.txt 
Ip: {{tu-ip }}
Distribucion: {{ tu-distro }}
Cantidad de cores: {{ cores }}
/tmp/2do_parcial/equipo/datos_equipo.txt 
Nombre: {{ nombre_alumno }}
Apellido: {{ apellido_alumno }}
Division: {{ division }}

#3) Creamos el archivo con las tareas
---
- name: Crear directorios para archivos
  file:
  path: "{{ item }}"
  state: directory
  mode: '0755'
with_items:
    - "/tmp/2do_parcial/alumno"
    - "/tmp/2do_parcial/equipo"

- name: Crear archivo de datos del alumno
  template:
  src: "templates/datos_alumno.txt.j2"
  dest: "/tmp/2do_parcial/alumno/datos_alumno.txt"
  mode: '0644'

- name: Crear archivo de datos del equipo
  template:
  src: "templates/datos_equipo.txt.j2"
  dest: "/tmp/2do_parcial/equipo/datos_equipo.txt"
  mode: '0644'


#4) Configuramos sudoers para que todo usuario del grupo “2PSupervisores” no requiera password al ejecutar sudo
- name: Configurar sudoers para que el grupo 2PSupervisores no requiera contraseña
  lineinfile:
  path: /etc/sudoers
  regexp: '^%2PSupervisores'
  line: '%2PSupervisores ALL=(ALL) NOPASSWD: ALL'
  validate: '/usr/sbin/visudo -cf %s'
become: true
