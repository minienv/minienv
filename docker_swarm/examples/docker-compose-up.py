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

def ps_(project):
    """
    containers status
    """
    logging.info('ps ' + project.name)
    running_containers = project.containers(stopped=True)

    items = [{
        'name': container.name,
        'name_without_project': container.name_without_project,
        'command': container.human_readable_command,
        'state': container.human_readable_state,
        'labels': container.labels,
        'ports': container.ports,
        'volumes': get_volumes(get_container_from_id(project.client, container.id)),
        'is_running': container.is_running} for container in running_containers]

    return items

def get_container_from_id(my_docker_client, container_id):
    """
    return the docker container from a given id
    """
    return Container.from_id(my_docker_client, container_id)

def get_volumes(container):
    """
    retrieve container volumes details
    """
    mounts = container.get('Mounts')
    return [dict(source=mount['Source'], destination=mount['Destination']) for mount in mounts]

def get_project(path, name, file):
    """
    get docker project given file path
    """
    logging.debug('get project ' + path)

    environment = Environment.from_env_file(path)
    if file is not None:
        environment['COMPOSE_FILE'] = file
    config_path = get_config_path_from_options(path, dict(), environment)
    project = compose_get_project(path, config_path, project_name=name)
    return project

p = get_project('./', 'example1', 'docker-compose-example1.yml')
p.up()
print(ps_(p))
