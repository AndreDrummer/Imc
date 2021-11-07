import 'package:intl/intl.dart';

class Formatters {
  static String dateDDMMYY(DateTime dateTime) {
    return DateFormat('dd/MM/yy').format(dateTime);
  }

  static String timeHHMM(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }
}
