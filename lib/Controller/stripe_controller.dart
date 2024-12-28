import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe/Service/payment_service.dart';

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
      Get.snackbar("Success", "Payment successful");
    } on StripeException {
      Get.snackbar("Cancelled", "Payment cancelled");
    } catch (e) {
      Get.snackbar("Error", "Payment failed: $e");
    }
  }
}
