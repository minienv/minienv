"""
bridge to docker-compose
"""

import logging
import os
from os.path import normpath
from compose.container import Container
from compose.cli.command import get_project as compose_get_project, get_config_path_from_options
from compose.config.environment import Environment

from compose.const import API_VERSIONS, COMPOSEFILE_V3_0

def get_project(path, name):
    """
    get docker project given file path
    """
    logging.debug('get project ' + path)

    environment = Environment.from_env_file(path)
    config_path = get_config_path_from_options(path, dict(), environment)
    project = compose_get_project(path, config_path, project_name=name)
    return project

os.environ["EXUP_GIT_REPO"] = "https://github.com/markwatsonatx/tutorial-rethinkdb-nodejs-rps"
p = get_project('./', 'example1')
p.up()

