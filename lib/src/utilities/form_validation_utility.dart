class FormValidationUtility {
  static RegExp nameRegex = RegExp(r"^[A-Z][-a-zA-Z]+$");

  static RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //static RegExp passwordRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9]);
  static String? validateName(String name) {
    name = name.trim();
    if (name.isEmpty) {
      return "Please enter the name";
    } else if (name.length < 3) {
      return "Please enter a valid name";
    } else if (!nameRegex.hasMatch(name)) {
      return "Please enter a valid name";
    } else {
      return null;
    }
  }

  static String? validateEmail(String email) {
    email = email.trim();
    if (email.isEmpty) {
      return "Please enter the email";
    } else if (!emailRegex.hasMatch(email)) {
      return "Please enter a valid email id";
    } else {
      return null;
    }
  }

  static String? validatePhone(String phone) {
    phone = phone.trim();
    if (phone.isEmpty) {
      return "Please enter phone number";
    } else if (phone.length != 10) {
      return "Must be 10 characters";
    } else {
      return null;
    }
  }
  static String? validateBirthDate(String bdayDate) {
    bdayDate = bdayDate.trim();
    if (bdayDate.isEmpty) {
      return "Please select birthdate";
    } else {
      return null;
    }
  }
  static bool checkForBirthday(DateTime? birthday) {
    if(birthday== null) {
      return false;
    }
    DateTime now = DateTime.now();
    if(now.day==birthday.day && now.month==birthday.month) {
      return true;
    } else{
      return false;
    }
  }

}
