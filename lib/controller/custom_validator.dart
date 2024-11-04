class Validation {
  dynamic emailValidator(String value) {
    if (value.isEmpty) {
      return 'Enter your Email address';
    }
    if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return 'Enter a Valid Email address';
    }
    return null;
  }

  dynamic passwordValidator(String value) {
    String errorMessage = '';

    if (value.length < 6) {
      return errorMessage += 'Password must be longer than 6 characters.\n';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return errorMessage += '• Uppercase letter is missing.\n';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return errorMessage += '• Lowercase letter is missing.\n';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return errorMessage += '• Digit is missing.\n';
    }

    if (!value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      return errorMessage += '• Special character is missing.\n';
    }
    return null;
  }
}
