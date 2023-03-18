class FormValidator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is Required!';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is Required!';
    } else if (value.length < 6) {
      return 'Password should be at least 6 characters!';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    bool emailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value!);
    if (value.isEmpty) {
      return 'Email is Required!';
    } else if (!emailValid) {
      return 'Valid Email is Required!';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is Required!';
    } else if (value.length != 11) {
      return 'Phone Number should be at exactly 11 characters!';
    }
    return null;
  }

  static String? validateUserType(String? value) {
    if (value == null || value.isEmpty) {
      return 'UserType is Required!';
    }
    return null;
  }

  static String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Location is Required!';
    }
    return null;
  }
}
