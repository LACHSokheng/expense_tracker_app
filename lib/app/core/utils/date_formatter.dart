import 'package:intl/intl.dart';

class DateFormatter {
  // Example: Formats a date as 'dd MMM yyyy' (e.g., 25 Dec 2023)
  static String toDayMonthYear(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  // Example: Formats a date as 'EEEE, MMM d' (e.g., Monday, Dec 25)
  static String toWeekdayMonthDay(DateTime date) {
    return DateFormat('EEEE, MMM d').format(date);
  }

  // Example: Formats a date as 'MMMM yyyy' (e.g., December 2023)
  static String toMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  // You can add more specific formatters here as needed
}
