# PostgreSQL Odoo DEV en K3s

Namespace: dev

Imagen:
ghcr.io/jsolisba/odoo-postgres@sha256:f21bb47bcbc9c570860baef27f436dddbb9137703317afcd2a9ab143a614c98e

Recursos:
- StatefulSet: odoo-dev-postgres
- Service: odoo-dev-postgres
- PVC: odoo-dev-postgres-pvc
- ImagePullSecret: ghcr-odoo-pull
- Secret de base de datos: odoo-dev-postgres-auth

Configuración:
- POSTGRES_USER=odoo
- POSTGRES_DB=postgres
- PGDATA=/var/lib/postgresql/data
- POSTGRES_PASSWORD_FILE=/run/secrets/postgresql_password

Seguridad:
- No guardar contraseñas ni Secret YAML con valores reales en Git.
- No montar el volumen Docker Swarm original.
- No desplegar en produccion.
- No inicializar la base de datos hasta definir la estrategia de restauración DEV.

Validación:
sudo kubectl apply --dry-run=client -f k8s/dev/postgres/
sudo kubectl diff -f k8s/dev/postgres/

Despliegue:
Solo después de crear y verificar los Secrets, confirmar el
procedimiento de inicialización/restauración y aprobar el arranque.

Recuperación:
Conservar imagen por digest, PVC Retain y respaldos externos.
La restauración debe incluir base de datos y filestore compatibles.
