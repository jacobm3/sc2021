vault secrets enable database

vault write database/config/app1_db \
    plugin_name=mysql-database-plugin \
    connection_url="{{username}}:{{password}}@tcp(35.232.93.58:3306)/" \
    allowed_roles="app1-5s,app1-60s" \
    username="vault" \
    password="TEIyE8KcSWVrd48byu7k"

vault write database/roles/app1-5s \
    db_name=app1_db \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';" \
    default_ttl="5s" \
    max_ttl="24h"

vault write database/roles/app1-60s \
    db_name=app1_db \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';" \
    default_ttl="60s" \
    max_ttl="24h"


