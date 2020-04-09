from rest_framework.viewsets import ModelViewSet

from .models import User
from .serializers import UserModelSerializer


class UserModelViewSet(ModelViewSet):
    queryset = User.objects.order_by('id')
    serializer_class = UserModelSerializer
