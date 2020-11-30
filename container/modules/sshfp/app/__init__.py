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
''' Keyper API app '''
import logging
import json
from os import environ
from flask import Flask, jsonify
from flask_cors import CORS
from .utils.extensions import logs, ma
from .resources.errors import Error
from config import config

def create_app():
    ''' Create app '''
    app = Flask(__name__)

    flask_config = "config." + config.get(environ.get('FLASK_CONFIG'), 'ProductionConfig')

    app.config.from_object(flask_config)

    logs.init_app(app)

    app.logger.debug("flask_config: " + flask_config)

    ma.init_app(app)

    CORS(app)

    from .public import public as public_blueprint
    app.register_blueprint(public_blueprint)

    @app.errorhandler(Error)
    def handle_keyper_error(error):
        ''' Error Handler '''
        response = jsonify(error.to_dict())
        response.status_code = error.status_code
        return response

    return app


