import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class InternetConnectivity extends ChangeNotifier {
  ConnectivityResult result = ConnectivityResult.none;

  void changeToInternetGained(ConnectivityResult result, BuildContext context) {
    this.result = result;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Connected'),
      backgroundColor: Colors.green,
    ));
    notifyListeners();
  }

  void changeToInternetLost(ConnectivityResult result, BuildContext context) {
    this.result = result;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('NotConnected'),
      backgroundColor: Colors.red,
    ));
    notifyListeners();
  }
}
