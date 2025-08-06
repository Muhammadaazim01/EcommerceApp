import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<Map<String, dynamic>> createPaymentIntent({
    required String amount,
    String currency = 'usd',
  }) async {
    final url = Uri.parse("http://192.168.18.126:4242/create-payment-intent");

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
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to create PaymentIntent: ${response.body}");
    }
  }

  static String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    print("💰 Calculated Stripe Amount: $calculatedAmount");

    return calculatedAmount.toString();
  }
}
