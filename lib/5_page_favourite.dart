import 'dart:typed_data';
import 'dart:ui';

import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterrecruitmenttest/main.dart';
import 'package:flutterrecruitmenttest/sources/ReconnectingOverlay.dart';
import 'package:flutterrecruitmenttest/sources/data_structeres.dart';
import 'package:flutterrecruitmenttest/sources/navigation.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'sources/globals.dart' as globals;
import 'sources/interface.dart' as interfaces;
import 'sources/loading.dart' as loading;

class FavouritePageWidget extends StatefulWidget {
  const FavouritePageWidget({
    Key? key,
  }) : super(key: key);

  @override
  _FavouritePageWidgetState createState() => new _FavouritePageWidgetState();
}

class _FavouritePageWidgetState extends State<FavouritePageWidget> {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double main_scale = interfaces.CalculateMainScale(_width, _height);

    double _hight_top = _height - interfaces.top_menu_height * main_scale;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: interfaces.color_black,
        appBar: interfaces.PreferredSizeMenu(main_scale),
        bottomNavigationBar: interfaces.FloatingNavbarBottomMenu(),
        body: Container(
          width: _width,
          height: _hight_top,
          child: Stack(
            children: [
              Positioned(
                top: 30 * main_scale,
                left: 20 * main_scale,
                child: Container(
                  height: _hight_top - 30 * main_scale,
                  width: _width,
                  child: isEmptyList() == false
                      ? SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 15 * main_scale,
                                  bottom: 90 * main_scale),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int i = 0;
                                        i < globals.books.books.length;
                                        i++)
                                      if (globals.favorites_book.elementAt(i))
                                        interfaces.OneHorizontalItem(
                                          index: i,
                                          width: _width,
                                          callBack: () {
                                            setState(() {});
                                          },
                                          main_scale: main_scale,
                                        )
                                  ])))
                      : Center(
                          child: Container(
                            margin: EdgeInsets.only(right: 2 * 20 * main_scale),
                            child: RichText(
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                              text: TextSpan(
                                text: "empty list" + "",
                                style: TextStyle(
                                  color: interfaces.color_white,
                                  fontSize: 20,
                                  height: 1.8,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  bool isEmptyList() {
    for (int i = 0; i < globals.favorites_book.length; i++) {
      // print(" ??" + globals.favorites_book.elementAt(i).toString());
      if (globals.favorites_book.elementAt(i)) return false;
    }
    //print("true");
    return true;
  }
}
