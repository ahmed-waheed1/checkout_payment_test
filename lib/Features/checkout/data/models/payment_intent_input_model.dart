class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String? customerId; // Made optional

  PaymentIntentInputModel({
    this.customerId, // Made optional
    required this.amount,
    required this.currency,
  });

  toJson() {
    Map<String, dynamic> body = {
      'amount': amount.contains('.')
          ? (double.parse(amount) * 100).round().toString()
          : '${amount}00',
      'currency': currency,
      'automatic_payment_methods[enabled]': 'true',
    };

    // Only add customer if provided
    if (customerId != null) {
      body['customer'] = customerId;
    }

    return body;
  }
}
