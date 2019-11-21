#!/bin/sh

# CG9101-nanoWiPOM

# make the symbolic link for the web system
ln -s /rom/mnt/cust/web /www/wipom-service
ln -s /overlay/wipom/logs /www/wipom-service-logs

uci set m2mweb.custom_ui=ui
uci set m2mweb.custom_ui.brand_logo=
uci set m2mweb.custom_ui.company_logo=
uci set m2mweb.custom_ui.favicon=
uci set m2mweb.custom_ui.tabtitle='WiPOM Cloudgate'
uci set m2mweb.custom_ui.tagline=''
uci commit m2mweb
