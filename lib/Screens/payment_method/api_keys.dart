import 'package:flutter_dotenv/flutter_dotenv.dart';

class StripeKeys {
  static String get publishableKey =>
      dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';

  static String get secretKey => dotenv.env['STRIPE_SECRET_KEY'] ?? '';
}
