#!/bin/bash -e
#############################################################################
#                       Confidentiality Information                         #
#                                                                           #
# This module is the confidential and proprietary information of            #
# DBSentry Corp.; it is not to be copied, reproduced, or transmitted in any #
# form, by any means, in whole or in part, nor is it to be used for any     #
# purpose other than that for which it is expressly provided without the    #
# written permission of DBSentry Corp.                                      #
#                                                                           #
# Copyright (c) 2020-2021 DBSentry Corp.  All Rights Reserved.              #
#                                                                           #
#############################################################################

FIRST_START_DONE="${CONTAINER_STATE_DIR}/gunicorn-first-start-done"

if [ ! -e "$FIRST_START_DONE" ]; then
	touch $FIRST_START_DONE
fi

#log-helper info "Setting UID/GID for nginx to ${NGINX_UID}/${NGINX_GID}"
#[ "$(id -g nginx)" -eq ${NGINX_GID} ] || groupmod -g ${NGINX_GID} nginx
#[ "$(id -u nginx)" -eq ${NGINX_UID} ] || usermod -u ${NGINX_UID} -g ${NGINX_GID} nginx

cd /container/service/gunicorn/assets
[ -d sshfp ] && cp -r sshfp /var/www
#[ -d sshfp ] && mv sshfp /var/www
#cd /var/www

#[ -d /var/log/sshfp ] || mkdir /var/log/sshfp
#chown -R nginx:nginx /var/log/sshfp /var/www/sshfp

exit 0
