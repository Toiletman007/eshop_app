# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

import os

from firebase_functions import https_fn
from firebase_functions.options import set_global_options
from firebase_admin import initialize_app

import stripe
# For cost control, you can set the maximum number of containers that can be
# running at the same time. This helps mitigate the impact of unexpected
# traffic spikes by instead downgrading performance. This limit is a per-function
# limit. You can override the limit for each function using the max_instances
# parameter in the decorator, e.g. @https_fn.on_request(max_instances=5).
#set_global_options(max_instances=10)

initialize_app()
#
#
# @https_fn.on_request()
# def on_request_example(req: https_fn.Request) -> https_fn.Response:
#     return https_fn.Response("Hello world!")

stripe.api_key = os.environ.get("STRIPE_SECRET_KEY")

MIN_AMOUNT_BY_CURRENCY = {
    "czk": 1500,
    "usd": 50,
    "eur": 50,
}
@https_fn.on_call()
def create_payment_intent(req: https_fn.CallableRequest) -> dict:
    data = req.data or {}
    amount = data.get("amount")
    raw_currency = data.get("currency", "czk")
    
    if not isinstance(raw_currency, str):
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="Currency must be a string. (eg. 'czk')"
            )
        
    currency = raw_currency.strip().lower()
    if currency not in MIN_AMOUNT_BY_CURRENCY:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message=(f"Currency '{currency}' is not supported." f"Allowed: {', '.join(MIN_AMOUNT_BY_CURRENCY)}.")
            
        )
    if isinstance(amount, bool) or not isinstance(amount, int):
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message=(f"Amount must be an integer.")
        )
    min_amount = MIN_AMOUNT_BY_CURRENCY[currency]
    if amount < min_amount:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message=(f"Amount must be at least {min_amount} for currency '{currency.upper()}'.")
        )
            
    try:
        intent = stripe.PaymentIntent.create(
            amount=amount,
            currency=currency,
            automatic_payment_methods={"enabled": True},
        )
        return {"client_secret": intent.client_secret}
    except stripe.error.StripeError as e:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INTERNAL,
            message=(f"Stripe error: {str(e)}" f"{e.user_message or e}")
        )