import 'package:checkout_payment_test/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_test/Features/checkout/data/repos/checkout_repo.dart';
import 'package:checkout_payment_test/core/errors/failures.dart';
import 'package:checkout_payment_test/core/utils/stripe_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      await StripeService().makePayment(
        paymentIntentInputModel: paymentIntentInputModel,
      );

      return right(null);
    } on StripeException catch (e) {
      return left(
        ServerFailure(errMessage: e.error.message ?? 'Oops there was an error'),
      );
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
