import 'package:intl/intl.dart';

enum AlertAction {
  cancel,
  discard,
  disagree,
  agree,
}

const String apiURL = "http://dev.bidsolution.mn/Onemis.ActiveFinance.WebAPI/";
const bool isEmployee = false;
const bool devMode = false;
const double textScaleFactor = 1.0;

final formatNumber = new NumberFormat("###,##0.####;(###,##0.####);");
final formatDecimal = new NumberFormat("###,##0.00;(###,##0.00);");
final formatDate = new DateFormat("yyyy-MM-dd");
final formatDateTime = new DateFormat("yyyy-MM-dd HH:mm:ss");
