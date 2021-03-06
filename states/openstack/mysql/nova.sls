nova-mysql:
  mysql_database.present:
    - name: {{ pillar['nova']['NOVA_DBNAME'] }}
    - require:
      - service: mysql-server
  mysql_user.present:
    - name: {{ pillar['nova']['NOVA_USER'] }}
    - host: {{ pillar['nova']['HOST_ALLOW'] }}
    - password: {{ pillar['nova']['NOVA_PASS'] }}
    - require:
      - mysql_database: nova-mysql
  mysql_grants.present:
    - grant: all
    - database: {{ pillar['nova']['DB_ALLOW'] }}
    - user: {{ pillar['nova']['NOVA_USER'] }}
    - host: {{ pillar['nova']['HOST_ALLOW'] }}
    - require:
      - mysql_user: nova-mysql
