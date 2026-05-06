abstract class CustomValidators {
  static bool phoneValidator({required String value}) {
    if (value.length == 10 && int.parse(value.split('').first) > 5) {
      return true;
    } else {
      return false;
    }
  }

  static bool emailValidator({required String value}) {
    const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

    return RegExp(emailRegex).hasMatch(value);
  }
}
