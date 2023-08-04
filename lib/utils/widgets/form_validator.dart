class FormValidator{
  static String? Function(String?)? emptyFieldValidation({String? value}) =>
          (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      };
}