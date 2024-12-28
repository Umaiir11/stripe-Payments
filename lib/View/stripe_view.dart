import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:stripe/Controller/stripe_controller.dart';


class StripeView extends StatelessWidget {
  const StripeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentController());

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text(
          'Stripe',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await paymentController.makePayment();
          },
          child: const Text('Pay'),
        ),
      ),
    );
  }
}
