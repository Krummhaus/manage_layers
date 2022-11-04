docker run -d \
	--name dev-postgis \
	-v ${pwd}/.postgis-data/:/var/lib/postgresql/data \
	-p 5432:5432 \
	-v ${pwd}/.sql/setup-db.sql:/docker-entrypoint-initdb.d/setup-db.sql kartoza/postgis:13.0
