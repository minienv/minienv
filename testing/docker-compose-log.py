"""
bridge to docker-compose
"""

import logging
import sys
from os.path import normpath
from compose.container import Container
from compose.cli.command import get_project as compose_get_project, get_config_path_from_options, get_config_from_options
from compose.config.config import get_default_config_files
from compose.config.environment import Environment

from compose.cli.docker_client import docker_client
from compose.const import API_VERSIONS, COMPOSEFILE_V3_0
from compose.cli.log_printer import build_log_presenters
from compose.cli.log_printer import LogPrinter

class writer :
    def write(self, text) :
        sys.stdout.write("HI: " + text)

    def flush(self):
        sys.stdout.flush()

def get_project(path):
    """
    get docker project given file path
    """
    logging.debug('get project ' + path)

    environment = Environment.from_env_file(path)
    config_path = get_config_path_from_options(path, dict(), environment)
    project = compose_get_project(path, config_path)
    return project

def list_containers(containers):
    return ", ".join(c.name for c in containers)

writer = writer()

def log_printer_from_project(
    project,
    containers,
    monochrome,
    log_args,
    cascade_stop=False,
    event_stream=None,
):
    return LogPrinter(
        containers,
        build_log_presenters(project.service_names, monochrome),
        event_stream or project.events(),
        cascade_stop=cascade_stop,
        log_args=log_args,
        output=writer)

p = get_project('/Users/markwatson/dev/github/markwatsonatx/tutorial-rethinkdb-nodejs-changes/')
containers = p.containers(stopped=True)
log_args = {
    'follow': True,
    'timestamps': True
}
print("Attaching to", list_containers(containers))
log_printer_from_project(
    p,
    containers,
    True,
    log_args,
    event_stream=p.events()).run()