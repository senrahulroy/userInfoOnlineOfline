import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// ------------ App enum ------------

enum TextSizes { small, medium, large }

/// --------- All app string ----------
class AppString {
  /// Single Tones
  AppString._();

  static const String hiveOpenDatabaseName = "MyUserData";
  static const String hiveFindDatabaseName = "MyUserData";
  static const String userDetails = "User Details";
  static const String firstName = "First Name";
  static const String firstNameHint = "Enter first name ";
  static const String lastName = "Last Name";
  static const String noData = "No Record Found. \n Please enter the data";
  static const String lastNameHint = "Enter last name";
  static const String email = "Email Address";
  static const String emailHint = "Enter email address";
  static const String yourMessage = "Your Message";
  static const String yourMessageHint = "Enter your question or message";
  static const String submittedMessage = "Submitted Message";
}

/// App All assets configuration class
class AppAssets {
  AppAssets._(); // singleton
  /// Common path for json
  static String jsonPath(String fileName) {
    return "assets/json/$fileName";
  }

  /// All json String
  static String get emptyJson => jsonPath("empty.json");
  static String get loaderJson => jsonPath("loader.json");
}

class AppSizes {
  // Default spacing between sections
  static const double defaultSpace = 18.0;
  static const double appBarHeight = 48.0;
  static const double spaceBtwItems = 16.0;
  static const double spaceBtwSections = 32.0;
  static const double commonBorder = 10.0;
}

/// App Default padding
class AppScreenDefaultPadding {
  static const EdgeInsetsGeometry paddingWithAppbarHeight = EdgeInsets.only(
      top: AppSizes.appBarHeight,
      left: AppSizes.defaultSpace,
      right: AppSizes.defaultSpace,
      bottom: AppSizes.defaultSpace);
}

class CustomDialogBox {

  /// Custom Loader
  static void openLoader(BuildContext context) {
    showDialog(
      barrierColor: Colors.white,
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: SizedBox(
          width: double.minPositive,
          height: double.minPositive,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 150,
                  height: 150,
                  child: Lottie.asset(AppAssets.loaderJson)
              ),
              const SizedBox(height: 20),
              const Text(
                'We are processing your information \n please wait...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );

  }

   /// Stop the Currently Open loading dialog.  ,
  ///  this Method Doesn't return anything.
  static stopLoadingDialog(BuildContext context) => Navigator.of(context).pop();

}
class CustomSnackBar {

  /// Warning SnackBar
  static void warningSnackBar({
    required BuildContext context,
    required String title,
    String msg = '',
    int duration = 2,
  }) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$title\n$msg',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: duration),
        action: SnackBarAction(
          label: 'Close',
          backgroundColor: Colors.red,
          disabledBackgroundColor: Colors.red,
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// Success SnackBar
  static void successSnackBar({
    required BuildContext context,
    required String title,
    String msg = '',
    int duration = 2,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$title\n$msg',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green, // Use your desired background color
        duration: Duration(seconds: duration),
        action: SnackBarAction(
          label: 'Close',
          backgroundColor: Colors.red,
          disabledBackgroundColor: Colors.red,
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }




}



class AppTextStyle {
  static TextStyle get messageStyle => const TextStyle(
        fontSize: AppSizes.defaultSpace,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get nameStyle => const TextStyle(
        fontSize: AppSizes.spaceBtwItems,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get emailStyle => const TextStyle(
        fontSize: AppSizes.spaceBtwItems - 2,
        color: Colors.grey,
      );
}

/// field validator
class AppValidator {
  /// This is for empty text field
  static String? validateEmptyText(String fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  /// This is for email id
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }
}
