class PaymentDetailsModel {
  final String id;
  final int amount;
  final String currency;
  final String status;
  final int? feeAmount;
  final String? description;

  PaymentDetailsModel({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    this.feeAmount,
    this.description,
  });

  factory PaymentDetailsModel.fromMap(Map<String, dynamic> map) {
    final charges = map['charges']['data']?.first ?? {};
    return PaymentDetailsModel(
      id: map['id'] ?? 'Unknown',
      amount: map['amount'] ?? 0,
      currency: map['currency'] ?? 'Unknown',
      status: map['status'] ?? 'Unknown',
      feeAmount: charges['fee'] ?? 0,
      description: charges['description'],
    );
  }

  /// Converts the model to a JSON-compatible Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'currency': currency,
      'status': status,
      'feeAmount': feeAmount,
      'description': description,
    };
  }

  @override
  String toString() {
    return '''
    Payment ID: $id
    Amount: ${amount / 100} $currency
    Status: $status
    Fee: ${feeAmount != null ? feeAmount! / 100 : 'N/A'} $currency
    Description: ${description ?? 'No description provided'}
    ''';
  }
}
