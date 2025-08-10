// lib/services/payment_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<Map<String, dynamic>> createPaymentIntent({
    required String amount,
    String currency = 'usd',
  }) async {
    final url = Uri.parse(
      "https://stripe-beckend-clean-b16p.vercel.app/create-payment-intent",
    );

    final body = jsonEncode({
      'amount': calculateAmount(amount),
      'currency': currency,
    });

    print("🔗 Request URL: $url");
    print("📦 Request Body: $body");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print("📥 Response Status: ${response.statusCode}");
    print("📥 Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['clientSecret'] == null) {
        throw Exception("Client secret not found in response.");
      }
      return data;
    } else {
      throw Exception("❌ Failed to create PaymentIntent: ${response.body}");
    }
  }

  static String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100; // Converts to cents
    print("💰 Calculated Stripe Amount: $calculatedAmount");
    return calculatedAmount.toString();
  }
}
