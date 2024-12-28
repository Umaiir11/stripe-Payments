import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:logger/logger.dart';
import 'package:stripe/Service/payment_service.dart';

import '../Model/payment_model.dart';

class PaymentController extends GetxController {
  final PaymentService _paymentService = PaymentService();
  RxMap<String, dynamic> paymentIntent = RxMap<String, dynamic>();

  Future<void> makePayment() async {
    try {
      paymentIntent.value = await _paymentService.createPaymentIntent('10', 'USD');

      if (paymentIntent['client_secret'] == null) {
        throw Exception("Client secret is null");
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'] ?? "",
          googlePay: PaymentSheetGooglePay(
            testEnv: true,
            currencyCode: 'USD',
            merchantCountryCode: 'US',
          ),
          merchantDisplayName: 'TestByUmair',
        ),
      );

       displayPaymentSheet();
    } catch (e) {
      Get.snackbar("Error", "Failed to initiate payment: $e");
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      await _fetchAndDisplayPaymentDetails(paymentIntent['id']);

      Get.snackbar("Success", "Payment successful");
    } on StripeException {
      Get.snackbar("Cancelled", "Payment cancelled");
    } catch (e) {
      Get.snackbar("Error", "Payment failed: $e");
    }
  }

  final logger = Logger();
  Future<void> _fetchAndDisplayPaymentDetails(String paymentIntentId) async {
    try {
      final paymentDetails = await _paymentService.getPaymentDetails(paymentIntentId);
      await _showPaymentDetails(paymentDetails);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch payment details: $e");
    }
  }
  Future<void> _showPaymentDetails(Map<String, dynamic> paymentDetails) async {
    try {
      final details = PaymentDetailsModel.fromMap(paymentDetails);
      logger.i("Payment Details JSON: ${details.toJson()}");
      final jsonPayload = details.toJson();
      logger.i("Full Payment Details:\n$jsonPayload");
    } catch (e) {
      throw Exception('Error displaying payment details: $e');
    }
  }
}
