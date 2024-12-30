class PaymentDetailsModel {
  final String id;
  final String object;
  final int amount;
  final int amountCapturable;
  final Map<String, dynamic>? amountDetails;
  final int amountReceived;
  final String? application;
  final int? applicationFeeAmount;
  final String? automaticPaymentMethods;
  final int? canceledAt;
  final String? cancellationReason;
  final String captureMethod;
  final String clientSecret;
  final String confirmationMethod;
  final int created;
  final String currency;
  final String? customer;
  final String? description;
  final String? invoice;
  final String? lastPaymentError;
  final String? latestCharge;
  final bool livemode;
  final Map<String, dynamic> metadata;
  final String? nextAction;
  final String? onBehalfOf;
  final String? paymentMethod;
  final Map<String, dynamic>? paymentMethodConfigurationDetails;
  final Map<String, dynamic>? paymentMethodOptions;
  final List<String> paymentMethodTypes;
  final String? processing;
  final String? receiptEmail;
  final String? review;
  final String? setupFutureUsage;
  final String? shipping;
  final String? source;
  final String? statementDescriptor;
  final String? statementDescriptorSuffix;
  final String status;
  final String? transferData;
  final String? transferGroup;

  PaymentDetailsModel({
    required this.id,
    required this.object,
    required this.amount,
    required this.amountCapturable,
    required this.amountDetails,
    required this.amountReceived,
    this.application,
    this.applicationFeeAmount,
    this.automaticPaymentMethods,
    this.canceledAt,
    this.cancellationReason,
    required this.captureMethod,
    required this.clientSecret,
    required this.confirmationMethod,
    required this.created,
    required this.currency,
    this.customer,
    this.description,
    this.invoice,
    this.lastPaymentError,
    this.latestCharge,
    required this.livemode,
    required this.metadata,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    this.paymentMethodConfigurationDetails,
    this.paymentMethodOptions,
    required this.paymentMethodTypes,
    this.processing,
    this.receiptEmail,
    this.review,
    this.setupFutureUsage,
    this.shipping,
    this.source,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    required this.status,
    this.transferData,
    this.transferGroup,
  });

  factory PaymentDetailsModel.fromMap(Map<String, dynamic> map) {
    return PaymentDetailsModel(
      id: map['id'] ?? '',
      object: map['object'] ?? '',
      amount: map['amount'] ?? 0,
      amountCapturable: map['amount_capturable'] ?? 0,
      amountDetails: map['amount_details'] as Map<String, dynamic>?,
      amountReceived: map['amount_received'] ?? 0,
      application: map['application'],
      applicationFeeAmount: map['application_fee_amount'],
      automaticPaymentMethods: map['automatic_payment_methods'],
      canceledAt: map['canceled_at'],
      cancellationReason: map['cancellation_reason'],
      captureMethod: map['capture_method'] ?? '',
      clientSecret: map['client_secret'] ?? '',
      confirmationMethod: map['confirmation_method'] ?? '',
      created: map['created'] ?? 0,
      currency: map['currency'] ?? '',
      customer: map['customer'],
      description: map['description'],
      invoice: map['invoice'],
      lastPaymentError: map['last_payment_error'],
      latestCharge: map['latest_charge'],
      livemode: map['livemode'] ?? false,
      metadata: Map<String, dynamic>.from(map['metadata'] ?? {}),
      nextAction: map['next_action'],
      onBehalfOf: map['on_behalf_of'],
      paymentMethod: map['payment_method'],
      paymentMethodConfigurationDetails: map['payment_method_configuration_details'] as Map<String, dynamic>?,
      paymentMethodOptions: map['payment_method_options'] as Map<String, dynamic>?,
      paymentMethodTypes: List<String>.from(map['payment_method_types'] ?? []),
      processing: map['processing'],
      receiptEmail: map['receipt_email'],
      review: map['review'],
      setupFutureUsage: map['setup_future_usage'],
      shipping: map['shipping'],
      source: map['source'],
      statementDescriptor: map['statement_descriptor'],
      statementDescriptorSuffix: map['statement_descriptor_suffix'],
      status: map['status'] ?? '',
      transferData: map['transfer_data'],
      transferGroup: map['transfer_group'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'amount': amount,
      'amount_capturable': amountCapturable,
      'amount_details': amountDetails,
      'amount_received': amountReceived,
      'application': application,
      'application_fee_amount': applicationFeeAmount,
      'automatic_payment_methods': automaticPaymentMethods,
      'canceled_at': canceledAt,
      'cancellation_reason': cancellationReason,
      'capture_method': captureMethod,
      'client_secret': clientSecret,
      'confirmation_method': confirmationMethod,
      'created': created,
      'currency': currency,
      'customer': customer,
      'description': description,
      'invoice': invoice,
      'last_payment_error': lastPaymentError,
      'latest_charge': latestCharge,
      'livemode': livemode,
      'metadata': metadata,
      'next_action': nextAction,
      'on_behalf_of': onBehalfOf,
      'payment_method': paymentMethod,
      'payment_method_configuration_details': paymentMethodConfigurationDetails,
      'payment_method_options': paymentMethodOptions,
      'payment_method_types': paymentMethodTypes,
      'processing': processing,
      'receipt_email': receiptEmail,
      'review': review,
      'setup_future_usage': setupFutureUsage,
      'shipping': shipping,
      'source': source,
      'statement_descriptor': statementDescriptor,
      'statement_descriptor_suffix': statementDescriptorSuffix,
      'status': status,
      'transfer_data': transferData,
      'transfer_group': transferGroup,
    };
  }
}
