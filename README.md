# Flutter Checkout Payment 💳

A powerful and secure Flutter application demonstrating modern payment integration with **Stripe** and **PayPal**. Built with clean architecture principles and industry-standard security practices for seamless e-commerce experiences.

## 📱 About Flutter Checkout Payment

Flutter Checkout Payment is a comprehensive payment processing application that showcases how to integrate multiple payment providers in a Flutter app. Whether you're building an e-commerce platform, subscription service, or any app requiring payment functionality, this project provides the foundation you need with secure, scalable, and user-friendly payment flows.

### ✨ Key Features

- **Multi-Payment Integration**: Seamless Stripe and PayPal payment processing
- **Secure API Management**: Industry-standard API key protection with gitignore
- **Automatic Payment Methods**: Stripe's intelligent payment method detection
- **Guest Checkout**: No customer account required for quick payments
- **Cart Management**: Full shopping cart with item management and totals
- **Payment Confirmation**: Success/failure handling with detailed feedback
- **Error Handling**: Comprehensive error management and user feedback
- **Clean Architecture**: Well-structured codebase with separation of concerns
- **State Management**: Cubit/Bloc pattern for predictable state handling
- **Responsive Design**: Optimized for various screen sizes and orientations

## 🛠 Tech Stack

### Core Framework

- **Flutter**: Cross-platform mobile app development
- **Dart**: Programming language

### Payment Processing

- **Stripe SDK**: Industry-leading payment processing
- **Flutter Stripe**: Official Stripe Flutter plugin
- **PayPal SDK**: PayPal payment integration
- **Stripe Payment Sheet**: Native payment UI components

### State Management & Architecture

- **Flutter BLoC/Cubit**: Business Logic Component pattern
- **Clean Architecture**: Separation of data, domain, and presentation layers
- **Repository Pattern**: Data access abstraction

### Networking & API

- **Dio**: HTTP client for API communication
- **Retrofit**: Type-safe HTTP client (optional)
- **JSON Annotation**: Model serialization support

### UI & Design

- **Material Design**: Modern UI components
- **Custom Widgets**: Reusable payment UI components
- **Responsive Layout**: Adaptive design for different screen sizes

### Security & Development

- **API Key Protection**: Secure credential management
- **Environment Configuration**: Development/production separation
- **Flutter Lints**: Code quality enforcement
- **Git Security**: Sensitive data protection

## 🏗 Project Structure

```
lib/
├── main.dart                           # App entry point
├── core/
│   ├── errors/                        # Error handling
│   ├── functions/                     # Utility functions
│   ├── utils/                         # Core utilities
│   │   ├── api_service.dart          # HTTP client service
│   │   ├── stripe_service.dart       # Stripe integration
│   │   ├── api_keys.dart            # API credentials (gitignored)
│   │   ├── api_keys_template.dart   # Template for setup
│   │   └── styles.dart              # App styling
│   └── widgets/                       # Reusable UI components
└── Features/
    └── checkout/
        ├── data/
        │   ├── models/               # Data models
        │   │   ├── amount_model/     # Payment amount structures
        │   │   ├── payment_intent_model/ # Stripe payment intent
        │   │   ├── ephemeral_key_model/  # Stripe ephemeral keys
        │   │   └── item_list_model/  # PayPal item structures
        │   └── repos/                # Repository implementations
        │       ├── checkout_repo.dart
        │       └── checkout_repo_impl.dart
        └── presentation/
            ├── manager/              # State management
            │   └── cubit/           # Payment Cubit
            └── views/               # UI screens and widgets
                ├── my_cart_view.dart
                ├── payment_details.dart
                ├── thank_you_view.dart
                └── widgets/         # Feature-specific widgets
```

## � Getting Started

### Prerequisites

- Flutter SDK (>=3.8.1)
- Dart SDK
- Android Studio / VS Code
- **Stripe Test Account** - [Sign up here](https://dashboard.stripe.com/register)
- **PayPal Developer Account** - [Sign up here](https://developer.paypal.com/)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/ahmed-waheed1/checkout_payment_test.git
   cd checkout_payment_test
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Set up API Keys** (Critical Step)

   ```bash
   # Copy the template file
   cp lib/core/utils/api_keys_template.dart lib/core/utils/api_keys.dart
   ```

4. **Configure your API keys** in `lib/core/utils/api_keys.dart`:

   ```dart
   class ApiKeys {
     const ApiKeys._();
     static const String puplishableKey = 'pk_test_YOUR_STRIPE_PUBLISHABLE_KEY';
     static const String secretKey = 'sk_test_YOUR_STRIPE_SECRET_KEY';
     static const String clientID = 'YOUR_PAYPAL_CLIENT_ID';
     static const String paypalSecretKey = 'YOUR_PAYPAL_SECRET_KEY';
   }
   ```

5. **Run the application**
   ```bash
   flutter run
   ```

### 🔑 API Keys Setup Guide

#### Get Stripe API Keys

1. Go to [Stripe Dashboard](https://dashboard.stripe.com/test/apikeys)
2. Copy your **Publishable key** (starts with `pk_test_`)
3. Copy your **Secret key** (starts with `sk_test_`)

#### Get PayPal API Keys

1. Go to [PayPal Developer](https://developer.paypal.com/developer/applications/)
2. Create a new app or use an existing one
3. Copy your **Client ID**
4. Copy your **Secret Key**

### Build for Production

**Android:**

```bash
flutter build apk --release
```

**iOS:**

```bash
flutter build ios --release
```

**Web:**

```bash
flutter build web --release
```

## � Core Models

### PaymentIntentInputModel

- **Amount**: Payment amount in cents
- **Currency**: Payment currency (USD, EUR, etc.)
- **Customer ID**: Optional customer identifier
- **Automatic Payment Methods**: Enabled for smart payment detection

### PaymentIntentModel

- **Client Secret**: Secure payment confirmation token
- **Status**: Payment status tracking
- **Amount Details**: Breakdown of payment amounts

### EphemeralKeyModel

- **Secret**: Temporary customer authentication
- **Associated Objects**: Customer relationship data

## 🔧 Payment Integration Details

### Stripe Integration

- **Payment Intents API**: Secure server-side payment processing
- **Automatic Payment Methods**: Supports cards, digital wallets, BNPL
- **Payment Sheet**: Native UI for payment collection
- **No Customer Required**: Simplified guest checkout
- **Comprehensive Error Handling**: User-friendly error messages

### PayPal Integration

- **PayPal SDK**: Native PayPal payment experience
- **Sandbox Testing**: Safe testing environment
- **Transaction Management**: Complete payment lifecycle
- **Item-based Checkout**: Detailed transaction breakdown

## 🔒 Security Features

### API Key Protection

- **Git Ignore**: API keys never committed to version control
- **Template System**: Easy setup without exposing credentials
- **Environment Separation**: Development vs production configurations

### Payment Security

- **HTTPS Only**: All API communications encrypted
- **Token-based Auth**: Secure payment authorization
- **Input Validation**: Client and server-side validation
- **Error Sanitization**: No sensitive data in error messages

## 🧪 Testing

### Test Cards (Stripe)

```
Visa Success: 4242 4242 4242 4242
Visa Decline: 4000 0000 0000 0002
Mastercard: 5555 5555 5555 4444
American Express: 3782 822463 10005
CVC: Any 3 digits
Expiry: Any future date
```

### PayPal Testing

Use PayPal sandbox accounts:

- **Personal Account**: For buyer testing
- **Business Account**: For merchant testing

## 📊 API Integration Examples

### Create Payment Intent (Stripe)

```bash
curl https://api.stripe.com/v1/payment_intents \
  -u "sk_test_YOUR_SECRET_KEY:" \
  -d amount=2000 \
  -d currency=usd \
  -d "automatic_payment_methods[enabled]"=true
```

### Create Customer (Stripe)

```bash
curl https://api.stripe.com/v1/customers \
  -u "sk_test_YOUR_SECRET_KEY:" \
  -d name="John Doe" \
  -d email="john@example.com"
```

## 🎨 UI Components

### Payment Method Selection

- **Card Payment**: Stripe-powered card processing
- **PayPal**: Native PayPal integration
- **Digital Wallets**: Apple Pay, Google Pay support

### Cart Management

- **Item Display**: Product images and details
- **Quantity Control**: Add/remove items
- **Price Calculation**: Subtotal, tax, and total computation

### Payment Confirmation

- **Success Screen**: Transaction confirmation
- **Receipt Details**: Payment method and amount
- **Error Handling**: Clear error messages and retry options

## 🚨 Common Issues & Solutions

### Issue: "No such customer" Error

**Solution**:

```dart
// Use simple payment without customer
await stripeService.makeSimplePayment(amount: "100");
```

### Issue: API Key Errors

**Solution**:

1. Verify keys are correctly set in `api_keys.dart`
2. Ensure using test keys for development
3. Check key permissions in Stripe dashboard

### Issue: Build Errors

**Solution**:

```bash
flutter clean
flutter pub get
flutter run
```

## 📱 Supported Platforms

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 11+)
- ✅ **Web** (Limited mobile wallet support)

## 🔮 Future Enhancements

- [ ] **Subscription Payments**: Recurring payment support
- [ ] **Multi-currency**: Dynamic currency conversion
- [ ] **Payment Analytics**: Transaction insights and reporting
- [ ] **Offline Support**: Handle connectivity issues
- [ ] **Biometric Auth**: Fingerprint/Face ID for payment confirmation
- [ ] **Installment Payments**: Buy now, pay later options
- [ ] **Refund Management**: Admin refund functionality
- [ ] **Payment History**: Transaction tracking and receipts
- [ ] **Wallet Integration**: Apple Pay, Google Pay enhancement
- [ ] **International Cards**: Global payment method support

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-payment-feature`)
3. Follow the existing code style and architecture
4. Add tests for new payment features
5. Commit your changes (`git commit -m 'Add amazing payment feature'`)
6. Push to the branch (`git push origin feature/amazing-payment-feature`)
7. Open a Pull Request

### Development Guidelines

- Follow Clean Architecture principles
- Add comprehensive error handling
- Include unit tests for business logic
- Document API integrations
- Ensure security best practices

## � License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## � Support

If you encounter any issues or have questions:

1. Check the [Issues](../../issues) page for existing solutions
2. Create a new issue with:
   - Detailed error description
   - Steps to reproduce
   - Device/platform information
   - Payment provider (Stripe/PayPal)

### Helpful Resources

- [Stripe Documentation](https://stripe.com/docs)
- [PayPal Developer Docs](https://developer.paypal.com/docs/)
- [Flutter Payment Documentation](https://docs.flutter.dev/)

---

**Built with ❤️ by [Ahmed Waheed](https://github.com/ahmed-waheed1) using Flutter & Dart**

## Author 👨‍💻

**Ahmed Waheed** - [@ahmed-waheed1](https://github.com/ahmed-waheed1)

- 📧 Email: [Contact Me](mailto:ahmedwaheed4047@gmail.com)
- 💼 LinkedIn: [Ahmed Waheed](https://www.linkedin.com/in/ahmed-waheed11/)
- 🐱 GitHub: [@ahmed-waheed1](https://github.com/ahmed-waheed1)

---

**Happy Payment Processing! 💳✨**
