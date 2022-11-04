docker run -d postgis/postgis:14-3.3-alpine \
	-e POSTGRES_PASSWORD=pass \
	-v "$pwd"/.postgis-data/:/var/lib/postgresql/data \
	-p 5432:5432 
	

