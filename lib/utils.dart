import 'package:intl/intl.dart';

final currencyFormat = NumberFormat.currency(
  locale: "in_ID",
  symbol: "Rp",
  decimalDigits: 0,
);

String formatCurrency(int price) => currencyFormat.format(price);
