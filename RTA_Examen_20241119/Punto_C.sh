# ! Dentro de la carpeta:
UTNFRA_SO_2do_Parcial_Chavarri/202406/docker/

#2) Modificamos el archivo con los datos pedidos:
index.html
<div>
  <h1> Sistemas Operativos - UTNFRA </h1></br>
    <h2> 2do Parcial - noviembre 2024 </h2> </br>
      <h3> Fidel Espino</h3>
        <h3> División: 113</h3>
	</div>

	#a. Guardamos:
	:wq

	#b. Creamos el archivo Dockerfile:
	vim Dockerfile

	FROM nginx:latest

	COPY index.html /usr/share/nginx/html/index.html

	EXPOSE 80

	#c. Guardamos
	:wq

	#d. Creamos el run.sh:
	vim run.sh

	#!/bin/bash
	sudo docker run -d -p 8080:80 vhhss/2do_parcial:latest
	#e. Le damos permisos:
	sudo chmod 755 run.sh

	#f. Construimos la imagen:
	sudo docker build -t web1-espino .

	#g. Nos logueamos en docker
	sudo docker login -u espino004

	#h. Etiquetamos la imagen:
docker tag web1-espino chavarri/web1-espino:latest

#2) Hacemos el push a docker:
sudo docker push espino004/web1-espino:latest
