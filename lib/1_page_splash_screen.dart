import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'sources/loading.dart' as loading;
import 'sources/globals.dart' as globals;
import 'sources/interface.dart' as interfaces;
import 'sources/loading.dart';
import 'sources/navigation.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  bool _isLoaderVisible = false;
  late Future hasbeenloadedFuture;

  Future getStartingDatas(BuildContext context) async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
    ]);
    await Future.delayed(const Duration(milliseconds: 500), () {
      globals.next_page = "page_2";
      RouteNavigation(context);
    });
    return "ok";
  }

  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();

    hasbeenloadedFuture = getStartingDatas(context);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: hasbeenloadedFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Container(
              color: interfaces.color_black,
              child: Center(
                child: Container(
                  height: 200,
                  width: _width,
                  child: SvgPicture.asset(
                    interfaces.logo,
                    fit: BoxFit.contain,
                    matchTextDirection: true,
                  ),
                ),
              ),
            ),
            //  ),
          ); //,
        }
        return Container();
      },
    );
  }
}
