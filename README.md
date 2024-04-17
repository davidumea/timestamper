# Timestamper

Argo CD application that deploys a pod that does some read/write operations towards a PostgreSQL cluster.

## Image

Build and push the image to your registry

```bash
CR_DOMAIN=             # Container registry domain
CR_PROJECT=            # Container registry project
IMAGE_TAG=             # Image tag
DOCKER_USER=           # User for container registry
DOCKER_PASSWORD=       # Password for container registry

cd image/
docker build -t $CR_DOMAIN/$CR_PROJECT/timestamper:$IMAGE_TAG .
docker push $CR_DOMAIN/$CR_PROJECT/timestamper:$IMAGE_TAG
```

Configure image pull secret

```bash
kubectl create secret docker-registry pull-secret \
    --docker-server=$CR_DOMAIN \
    --docker-username=$DOCKER_USER \
    --docker-password=$DOCKER_PASSWORD

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "pull-secret"}]}'
```

## Postgres

Prepare postgres

```sql
CREATE DATABASE "dbname";
GRANT ALL ON DATABASE test TO "PGUSER";
\c "dbname"
CREATE TABLE timestamp (id BIGSERIAL NOT NULL PRIMARY KEY, timestamp TIMESTAMP not null);
GRANT ALL ON TABLE timestamp TO "PGUSER";
GRANT ALL ON TABLE timestamp_id_seq to "PGUSER";
```

## Application


