import 'dart:convert';
import 'package:http/http.dart' as http;

import 'global_variables.dart';

class PaymentService {
  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };


      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${GlobalKeys.gbStripeSecretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body.toString());
      } else {
        print('Failed to create Payment Intent: ${response.body}');
        throw Exception('Failed to create Payment Intent');
      }
    } catch (e) {
      print("Error creating Payment Intent: $e");
      throw Exception(e);
    }
  }
  Future<Map<String, dynamic>> getPaymentDetails(String paymentIntentId) async {
    try {
      final response = await http.get(
        Uri.parse("https://api.stripe.com/v1/payment_intents/$paymentIntentId"),
        headers: {
          'Authorization': 'Bearer ${GlobalKeys.gbStripeSecretKey}',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to fetch payment details: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error in getPaymentDetails: $e");
    }
  }

}
