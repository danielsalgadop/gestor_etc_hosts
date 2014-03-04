# rm -rf /var/www/html/84.gestor_etc_hosts/*
# rm -rf /var/www/cgi-bin/84.gestor_etc_hosts/*
rsync -rp --delete  /home/dan/cosas_hechas/84.gestor_etc_hosts/cgi-bin/ /var/www/cgi-bin/84.gestor_etc_hosts
rsync -rp --delete /home/dan/cosas_hechas/84.gestor_etc_hosts/html/ /var/www/html/84.gestor_etc_hosts
