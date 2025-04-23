class PaymentCard {
  String cardNumber;
  String cardHolderName;
  String expiryDate;
  String cvv;
  bool saveCard;

  PaymentCard({
    this.cardNumber = '',
    this.cardHolderName = '',
    this.expiryDate = '',
    this.cvv = '',
    this.saveCard = false,
  });

  bool isValid() {
    return cardNumber.length == 19 && // Including spaces
           cardHolderName.isNotEmpty &&
           expiryDate.length == 5 &&
           cvv.length == 3;
  }

  // Helper method to format card number
  static String formatCardNumber(String number) {
    String numbers = number.replaceAll(' ', '');
    String newString = '';
    for (int i = 0; i < numbers.length; i++) {
      if (i > 0 && i % 4 == 0) {
        newString += ' ';
      }
      newString += numbers[i];
    }
    return newString;
  }

  // Helper method to format expiry date
  static String formatExpiryDate(String date) {
    String numbers = date.replaceAll('/', '');
    String newString = '';
    for (int i = 0; i < numbers.length; i++) {
      if (i == 2) {
        newString += '/';
      }
      newString += numbers[i];
    }
    return newString;
  }
}