import 'package:checkout_payment_test/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_test/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
