import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppHelper {
  AppHelper();

  // Format date
  static String formateDate(String date) {
    if (date.isNotEmpty) {
      try {
        final finalDate = DateTime.parse(date).toLocal();
        return DateFormat("dd MMM, yyyy").format(finalDate);
      } catch (e) {
        // Handle parsing errors, e.g., return an error message or a default value
        return "Invalid date format";
      }
    } else {
      return "";
    }
  }

  // Format time
  static String formateTime(String time) {
    if (time.isNotEmpty) {
      try {
        final finalTime = DateTime.parse(time);
        return DateFormat("hh:mm a").format(finalTime);
      } catch (e) {
        // Handle parsing errors, e.g., return an error message or a default value
        return "Invalid time format";
      }
    } else {
      return "";
    }
  }

  // Format date and time
  static String formatDateTime(String date) {
    if (date.isNotEmpty) {
      try {
        final finalDateTime = DateTime.parse(date).toLocal();
        // return DateFormat("EEE, dd MMM yyyy - hh:mm a").format(finalDateTime);
        return DateFormat("dd MMM, yyyy hh:mm a").format(finalDateTime);
      } catch (e) {
        // Handle parsing errors, e.g., return an error message or a default value
        return "Invalid date format";
      }
    } else {
      return "";
    }
  }

  // Format date and time in local
  static String formatDateTimeLocal(String date) {
    if (date.isNotEmpty) {
      try {
        final finalDateTime = DateTime.parse(date).toLocal();
        return DateFormat("EEE, dd MMM yyyy - hh:mm a").format(finalDateTime);
      } catch (e) {
        // Handle parsing errors, e.g., return an error message or a default value
        return "Invalid date format";
      }
    } else {
      return "";
    }
  }

  // function for picking date
  static pickDate(BuildContext context, DateTime? initialDate,
      DateTime? firstDate, DateTime? endDate) async {
    try {
      DateTime? dateValue = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(1700),
        lastDate: endDate ?? DateTime(2101),
        locale: const Locale("en"), // Specify the desired locale
      );
      if (dateValue != null) {
        return dateValue;
      } else {
        throw Exception(
            "No date selected"); // Throw an error if no date is selected
      }
    } catch (e) {
      throw Exception(
          "Failed to show date picker: $e"); // Propagate the error with more information
    }
  }

  // function for picking time
  static pickTime(BuildContext context) async {
    try {
      TimeOfDay? timeValue = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (timeValue != null) {
        return timeValue;
      } else {
        throw Exception(
            "No time selected"); // Throw an error if no date is selected
      }
    } catch (e) {
      throw Exception(
          "Failed to show time picker: $e"); // Propagate the error with more information
    }
  }

  static void showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength);
    }
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }
}
