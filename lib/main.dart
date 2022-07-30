import 'package:flutter/material.dart';

import '1_page_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    /* SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);*/

    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      home: SplashScreenWidget(),
    );
  }
}
