import 'dart:async';

import 'package:covid_tracker/Services/Utitlities/networkerror_dialog.dart';
import 'package:covid_tracker/Views/world_states_screen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivityHelper {
  static bool isConnected = false;
  static Future<bool> checkInternetConnectivity(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool isConnected = connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;

    if (!isConnected) {
      showRetryDialog(context);
    }

    return isConnected;
  }

  static void showRetryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          message: 'No internet connection',
          fontsize: 20,
          message2: 'RETRY',
          onRetry: () {
            retryNavigation(context);
          },
        );
      },
    );
  }

  static void retryNavigation(BuildContext context) {
    // Check for internet connection again
    checkInternetConnectivity(context).then((result) {
      if (result) {
        navigateToMainScreen(context);
      } else {
        // Still not connected, show the alert again
        showRetryDialog(context);
      }
    });
  }

  static void navigateToMainScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => WorldStatesScreen(),
    ));
  }
}
