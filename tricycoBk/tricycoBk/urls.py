
from django.contrib import admin
from django.urls import path
from django.urls import include
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path("admin/", admin.site.urls),
     path("users/", include('users.urls', namespace="users")),
    path("auth/", include('authTokens.urls', namespace="auth")),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

admin.site.site_header = "Tricyco Application"
admin.site.site_title = "Tricyco Application"
admin.site.index_title = "Welcome to Tricyco"