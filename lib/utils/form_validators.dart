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

  static String? validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Account number is Required!';
    } else if (value.length != 10) {
      return 'Invalid account number!';
    }
    return null;
  }

  static String? validateUserType(String? value) {
    if (value == null || value.isEmpty) {
      return 'UserType is Required!';
    }
    return null;
  }

  static String? validateBankNames(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bank Name is Required!';
    }
    return null;
  }

  static String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Location is Required!';
    }
    return null;
  }

  static String? validateSeatNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Seat Number is Required!';
    }
    return null;
  }

  static String? validatePlateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Plate number is Required!';
    }
    return null;
  }

  static String? validateTricycleColor(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tricycle color is Required!';
    }
    return null;
  }

  static String? fundWallet(String? value) {
    if (value == null || value.isEmpty) {
      return 'amount is Required!';
    }
    if (double.parse(value.toString()) < 1) {
      return 'amount should be a positive number!';
    }
    return null;
  }

  static String? disburseFunds(String? value) {
    if (value == null || value.isEmpty) {
      return 'amount is Required!';
    }
    if (double.parse(value.toString()) < 499) {
      return 'minimum withdrawal is 500';
    }
    return null;
  }
}
