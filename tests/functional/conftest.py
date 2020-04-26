import pytest

from pytest_elasticsearch import factories

from elasticsearch_dsl.connections import add_connection


elasticsearch_proc = factories.elasticsearch_proc()
elasticsearch = factories.elasticsearch('elasticsearch_proc')


@pytest.fixture(autouse=True)
def init_db(elasticsearch):
    add_connection('default', elasticsearch)
