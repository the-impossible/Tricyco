from django.db import models
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, BaseUserManager

# Create your models here.
class UserManager(BaseUserManager):
    """ Extending the BaseUserManager"""

    def create_user(self, email, name, phone, password=None):
        """Creates a user account"""

        #creates a user with the parameters
        if not email:
            raise ValueError('Email Address is required!')

        if not name:
            raise ValueError('Fullname is required!')

        if not phone:
            raise ValueError('Phone number is required!')

        if password is None:
            raise ValueError('Password is required!')

        user = self.model(
            email = self.normalize_email(email),
            name = name.title().strip(),
            phone = phone.lower().strip(),
        )

        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, email, name, phone, password=None):
        """Creates a superuser account"""
        user = self.create_user(email, name, phone, password)
        user.is_staff = True
        user.is_superuser = True
        user.is_active = True
        user.save(using=self._db)

        return user


class User(AbstractBaseUser, PermissionsMixin):
    """Creates a User"""
    name = models.CharField(max_length=100)
    email = models.EmailField(db_index=True, unique=True, verbose_name='email address')
    phone = models.CharField(max_length=11, db_index=True, unique=True, blank=True, null=True)
    pic = models.ImageField(default='img/user.png', null=True, blank=True, upload_to='uploads/profile/')
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    date_joined = models.DateTimeField(verbose_name='date_joined', auto_now_add=True)
    last_login = models.DateTimeField(verbose_name='last_login', auto_now=True, null=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['name','phone','password']

    objects = UserManager()


    def __str__(self):
        return f'{self.email}'

    def get_fullname(self):
        """return the full name of the user"""
        return f'{self.name}'

    def has_perm(self, perm, obj=None):
        return self.is_staff

    def has_module_perms(self, app_label):
        return True


    class Meta:
        """Meta data for the class"""
        db_table = 'Users'
        verbose_name_plural = 'Users'
