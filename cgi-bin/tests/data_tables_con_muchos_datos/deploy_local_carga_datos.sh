rm -rf /var/www/html/carga_datatables/*
rm -rf /var/www/cgi-bin/carga_datatables/*
rsync -r --delete  /home/dan/cosas_hechas/84.gestor_etc_hosts/cgi-bin/tests/data_tables_con_muchos_datos/cgi-bin/ /var/www/cgi-bin/carga_datatables/
rsync -r --delete /home/dan/cosas_hechas/84.gestor_etc_hosts/cgi-bin/tests/data_tables_con_muchos_datos/html/ /var/www/html/carga_datatables/
