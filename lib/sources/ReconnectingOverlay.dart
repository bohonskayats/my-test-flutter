import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'globals.dart' as globals;
import 'interface.dart' as interfaces;

class ReconnectingOverlay extends StatefulWidget {
  const ReconnectingOverlay({Key? key}) : super(key: key);
  @override
  State<ReconnectingOverlay> createState() => _ReconnectingOverlay();
}

class _ReconnectingOverlay extends State<ReconnectingOverlay> {
  String text_loading = "";

  initState() {
    // TODO: implement initState
    super.initState();
    // setValue();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            width: 50,
            child: LoadingIndicator(
              indicatorType: Indicator.ballRotateChase,
              colors: [interfaces.loader_color],
            ),
          ),
        ],
      ),
    );
  }
}
