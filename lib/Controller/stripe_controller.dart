import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:logger/logger.dart';
import 'package:stripe/Service/payment_service.dart';

import '../Model/payment_model.dart';

class PaymentController extends GetxController {
  final PaymentService _paymentService = PaymentService();
  RxMap<String, dynamic> paymentIntent = RxMap<String, dynamic>();
  final logger = Logger();

  Future<void> makePayment() async {
    try {
      // Create payment intent
      paymentIntent.value = await _paymentService.createPaymentIntent('10', 'USD');
      logger.i("Payment intent created: ${paymentIntent.toString()}");

      if (paymentIntent['client_secret'] == null) {
        throw Exception("Client secret is null");
      }

      // Initialize the payment sheet
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
      logger.i("Payment sheet initialized");

      // Display the payment sheet
      await displayPaymentSheet();
    } catch (e) {
      logger.e("Failed to initiate payment: $e");
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      // Present the payment sheet to the user
      await Stripe.instance.presentPaymentSheet();
      logger.i("Payment sheet displayed successfully");

      // Fetch and display payment details
      if (paymentIntent.containsKey('id') && paymentIntent['id'] != null) {
        await _fetchAndDisplayPaymentDetails(paymentIntent['id']);
      } else {
        logger.e("PaymentIntent ID is null or missing.");
      }

      logger.i("Payment successful");
    } on StripeException {
      logger.e("Payment cancelled by the user");
    } catch (e) {
      logger.e("Payment failed: $e");
    }
  }

  Future<void> _fetchAndDisplayPaymentDetails(String paymentIntentId) async {
    try {
      // Fetch payment details
      final paymentDetails = await _paymentService.getPaymentDetails(paymentIntentId);
      logger.i("Fetched payment details: $paymentDetails");

      if (paymentDetails != null) {
        await _showPaymentDetails(paymentDetails);
      } else {
        logger.e("Payment details are null or missing 'data' key for PaymentIntent ID: $paymentIntentId");
      }
    } catch (e) {
      logger.e("Failed to fetch payment details: $e");
    }
  }

  Future<void> _showPaymentDetails(paymentDetails) async {
    try {
      if (paymentDetails.isEmpty) {
        throw Exception("Payment details map is empty");
      }

      // Parse and log payment details
      final details = PaymentDetailsModel.fromMap(paymentDetails);
      logger.i("Payment Details: ${details.toJson()}");

      final jsonPayload = details.toJson();
      logger.i("Full Payment Details:\n$jsonPayload");
    } catch (e) {
      logger.e("Error displaying payment details: $e");
    }
  }
}
