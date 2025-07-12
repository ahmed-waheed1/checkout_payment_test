# API Keys Setup

This project requires API keys from Stripe and PayPal. Follow these steps to set up your keys:

## 1. Create your API keys file

1. Copy `lib/core/utils/api_keys_template.dart` to `lib/core/utils/api_keys.dart`
2. Replace the placeholder values with your actual API keys

## 2. Get your Stripe API keys

1. Go to [Stripe Dashboard](https://dashboard.stripe.com/test/apikeys)
2. Copy your **Publishable key** (starts with `pk_test_`)
3. Copy your **Secret key** (starts with `sk_test_`)

## 3. Get your PayPal API keys

1. Go to [PayPal Developer](https://developer.paypal.com/developer/applications/)
2. Create a new app or use an existing one
3. Copy your **Client ID**
4. Copy your **Secret Key**

## 4. Update the api_keys.dart file

Replace the placeholder values in `lib/core/utils/api_keys.dart`:

```dart
class ApiKeys {
  const ApiKeys._();
  static const String puplishableKey = 'pk_test_YOUR_ACTUAL_KEY_HERE';
  static const String secretKey = 'sk_test_YOUR_ACTUAL_KEY_HERE';
  static const String clientID = 'YOUR_PAYPAL_CLIENT_ID_HERE';
  static const String paypalSecretKey = 'YOUR_PAYPAL_SECRET_KEY_HERE';
}
```

## Security Notes

- Never commit your actual API keys to version control
- The `api_keys.dart` file is already in `.gitignore`
- Use test keys for development
- Use environment variables in production
