import 'dart:async';

import 'package:covid_tracker/Views/world_states_screen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:covid_tracker/Services/network_connectivity.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

Future<bool> checkInternetConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  return connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi;
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  StreamSubscription<ConnectivityResult>? subscription;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkAndNavigate();

    // Subscribe to connectivity changes
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          checkAndNavigate();
        } else {
          InternetConnectivityHelper.showRetryDialog(context);
        }
      });
    });
  }

  Future<void> checkAndNavigate() async {
    bool isConnected =
        await InternetConnectivityHelper.checkInternetConnectivity(context);

    if (isConnected) {
      Timer(Duration(seconds: 3), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorldStatesScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: ((context, child) {
                        return Transform.rotate(
                          angle: _controller.value * 2.0 * math.pi,
                          child: child,
                        );
                      }),
                      child: Container(
                        height: 200,
                        width: 200,
                        child: Image(image: AssetImage('images/virus.png')),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                    ),
                    Text(
                      'Covid-24\nTracker App',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontSize: 30, color: Colors.white, letterSpacing: 5),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Column(
                    children: [
                      Text(
                        'Designed By Ashhad',
                        style: GoogleFonts.inter(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'ashhadahmed72@gmail.com',
                        style: GoogleFonts.inter(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
