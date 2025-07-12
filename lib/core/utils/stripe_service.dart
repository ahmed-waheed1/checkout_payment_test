import 'package:checkout_payment_test/Features/checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:checkout_payment_test/Features/checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:checkout_payment_test/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_test/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:checkout_payment_test/core/utils/api_keys.dart';
import 'package:checkout_payment_test/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  final ApiService apiService = ApiService();
  static const String _stripeApiVersion = '2023-08-16';

  Future<String> createCustomer({required String email, String? name}) async {
    try {
      final response = await apiService.post(
        body: {'email': email, if (name != null) 'name': name},
        contentType: Headers.formUrlEncodedContentType,
        url: 'https://api.stripe.com/v1/customers',
        token: ApiKeys.secretKey,
      );

      return response.data['id'] as String;
    } on DioException catch (e) {
      print('Error creating customer: $e');
      print('Response data: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('Unexpected error creating customer: $e');
      rethrow;
    }
  }

  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInputModel,
  ) async {
    try {
      final response = await apiService.post(
        body: paymentIntentInputModel.toJson(),
        contentType: Headers.formUrlEncodedContentType,
        url: 'https://api.stripe.com/v1/payment_intents',
        token: ApiKeys.secretKey,
      );

      return PaymentIntentModel.fromJson(response.data);
    } on DioException catch (e) {
      print('Error creating payment intent: $e');
      print('Response data: ${e.response?.data}');
      print('Request data: ${paymentIntentInputModel.toJson()}');
      rethrow;
    } catch (e) {
      print('Unexpected error creating payment intent: $e');
      rethrow;
    }
  }

  Future<void> initPaymentSheet({
    required InitiPaymentSheetInputModel initPaymentSheetInputModel,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: initPaymentSheetInputModel.clientSecret,
          customerEphemeralKeySecret:
              initPaymentSheetInputModel.ephemeralKeySecret,
          customerId: initPaymentSheetInputModel.customerId,
          merchantDisplayName: 'tharwat',
        ),
      );
    } catch (e) {
      print('Error initializing payment sheet: $e');
      rethrow;
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      print('Stripe payment error: ${e.error.localizedMessage}');
      rethrow;
    } catch (e) {
      print('Error displaying payment sheet: $e');
      rethrow;
    }
  }

  Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
    String? customerEmail,
    String? customerName,
  }) async {
    try {
      final paymentIntentModel = await createPaymentIntent(
        paymentIntentInputModel,
      );

      if (paymentIntentInputModel.customerId != null) {
        final ephemeralKeyModel = await createEphemeralKey(
          customerId: paymentIntentInputModel.customerId!,
        );

        await initPaymentSheet(
          initPaymentSheetInputModel: InitiPaymentSheetInputModel(
            clientSecret: paymentIntentModel.clientSecret!,
            customerId: paymentIntentInputModel.customerId!,
            ephemeralKeySecret: ephemeralKeyModel.secret!,
          ),
        );
      } else {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentModel.clientSecret!,
            merchantDisplayName: 'tharwat',
          ),
        );
      }

      await displayPaymentSheet();
    } on DioException catch (e) {
      if (e.response?.data?['error']?['code'] == 'resource_missing' &&
          customerEmail != null) {
        print('Customer not found, creating new customer...');
        final newCustomerId = await createCustomer(
          email: customerEmail,
          name: customerName,
        );

        await makePayment(
          paymentIntentInputModel: PaymentIntentInputModel(
            customerId: newCustomerId,
            amount: paymentIntentInputModel.amount,
            currency: paymentIntentInputModel.currency,
          ),
          customerEmail: customerEmail,
          customerName: customerName,
        );
      } else {
        rethrow;
      }
    } catch (e) {
      print('Error in makePayment: $e');
      rethrow;
    }
  }

  Future<void> makeSimplePayment({
    required String amount,
    String currency = 'usd',
  }) async {
    final paymentIntent = PaymentIntentInputModel(
      amount: amount,
      currency: currency,
    );

    await makePayment(paymentIntentInputModel: paymentIntent);
  }

  Future<void> makePaymentWithCustomer({
    required String amount,
    required String customerEmail,
    String? customerName,
    String currency = 'usd',
  }) async {
    final customerId = await createCustomer(
      email: customerEmail,
      name: customerName,
    );

    await makePayment(
      paymentIntentInputModel: PaymentIntentInputModel(
        amount: amount,
        currency: currency,
        customerId: customerId,
      ),
      customerEmail: customerEmail,
      customerName: customerName,
    );
  }

  Future<EphemeralKeyModel> createEphemeralKey({
    required String customerId,
  }) async {
    try {
      final response = await apiService.post(
        body: {'customer': customerId},
        contentType: Headers.formUrlEncodedContentType,
        url: 'https://api.stripe.com/v1/ephemeral_keys',
        token: ApiKeys.secretKey,
        headers: {
          'Authorization': "Bearer ${ApiKeys.secretKey}",
          'Stripe-Version': _stripeApiVersion,
        },
      );

      return EphemeralKeyModel.fromJson(response.data);
    } on DioException catch (e) {
      print('Error creating ephemeral key: $e');
      print('Response data: ${e.response?.data}');
      print('Customer ID: $customerId');
      rethrow;
    } catch (e) {
      print('Unexpected error creating ephemeral key: $e');
      rethrow;
    }
  }
}
