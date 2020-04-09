import pytest
from rest_framework.test import APIRequestFactory

from .views import UserModelViewSet


@pytest.mark.django_db
def test_list_users():
    factory = APIRequestFactory()
    view = UserModelViewSet.as_view({'get': 'list'})
    request = factory.get('/users/')
    response = view(request)
    assert response.status_code == 200
