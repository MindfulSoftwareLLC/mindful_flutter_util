import 'package:url_launcher/url_launcher.dart';

//https://hostedstripepage.web.app/
Future<bool> navigateToCheckout(
  String url,
  String clientSecret,
  double paymentAmount,
) async {
  String paymentAmountString = paymentAmount.toStringAsFixed(2);
  String url = "url?clientSecret=" +
      clientSecret +
      "&paymentAmount=" +
      paymentAmountString;

  final Uri uri = Uri.parse(url);
  final bool launched = await launchUrl(
    uri,
    webOnlyWindowName: '_self',
  );

  if (!launched) {
    print('$url Not launched');
    return false;
  }
  return true;
}
