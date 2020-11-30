#!/bin/sh -ex
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
# Build Vue frontend app
if [ -f /container/sshfp-fe/package.json ]; then
	cd /container/sshfp-fe
	npm install
	npm run build

	status=$?

	if [ $status -eq 0 ]; then
		mv dist /var/www/sshfp-fe
	else
		echo "##########################################################"
		echo "Error building sshfp-fe"
		echo "##########################################################"
	fi
else
	mkdir /var/www/sshfp-fe
fi

# Build and install flask modules/libraries
mv /container/sshfp /var/www
cd /var/www/sshfp
rm -rf env/*
python3 -m venv env
. env/bin/activate
pip install -r requirements.txt

status=$?

if [ $status -eq 0 ]; then
	cd /var/www
	tar -czf /container/out.tar.gz .
else
	echo "##########################################################"
	echo "Error building sshfp"
	echo "##########################################################"
fi
