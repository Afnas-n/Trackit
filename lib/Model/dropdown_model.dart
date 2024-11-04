class DropdownModel {

  String selectedValue = 'Food and Drink';

  // A map of dropdown items to their respective images
  final Map<String, String> dropdownItemImages = {
    'Food and Drink': 'assets/images/food.png',
    'Electricity': 'assets/images/electricity.png',
    'Home rent': 'assets/images/home.png',
    'Entertainment': 'assets/images/entertainment.png',
    'Health Insurance': 'assets/images/health_insurance.png',
    'Mobile recharge': 'assets/images/mobile.png',
    'Utilities': 'assets/images/utilities.png',
  };

  String getImageForSelectedValue() {
    return dropdownItemImages[selectedValue] ?? 'assets/images/default.png';
  }
}
