import pytest

from pytest_elasticsearch import factories

from elasticsearch_dsl.connections import add_connection


elasticsearch_nooproc = factories.elasticsearch_noproc('0.0.0.0', 9200)
elasticsearch = factories.elasticsearch('elasticsearch_nooproc')


@pytest.fixture(autouse=True)
def init_db(elasticsearch):
    add_connection('default', elasticsearch)
