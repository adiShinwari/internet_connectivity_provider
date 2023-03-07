import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:internet_connectivity_provider/provider/internet_connectivity.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Connectivity connectivity = Connectivity();
  late StreamSubscription streamSubscription;
  @override
  void initState() {
    final provider = Provider.of<InternetConnectivity>(context, listen: false);
    streamSubscription = connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        provider.changeToInternetGained(event,context);
      } else {
        provider.changeToInternetLost(event,context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Internet Connectivity Provider',
        ),
      ),
      body: Center(
        child: Consumer<InternetConnectivity>(
          builder: (context, value, child) {
            if (value.result == ConnectivityResult.mobile ||
                value.result == ConnectivityResult.wifi) {
              return const Text('Connected To Internet');
            } else if (value.result == ConnectivityResult.none) {
              return const Text('No Internet');
            } else {
              return const Text('Loading...');
            }
          },
        ),
      ),
    );
  }
}
