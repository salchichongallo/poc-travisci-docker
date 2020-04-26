import pytest
import elasticsearch_dsl as dsl


class User(dsl.Document):
    class Index:
        name = 'users'

    name = dsl.Text(required=True)


class TestUser:
    @pytest.fixture(autouse=True)
    def user_index(self, init_db):
        User.init()

    def test_user_finder(self):
        u = User()
        u.name = 'john doe'
        u.save(refresh=True)

        users = list(User().search().scan())
        assert len(users) == 1
