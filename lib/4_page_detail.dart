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

class DetailPageWidget extends StatefulWidget {
  const DetailPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  _DetailPageWidgetState createState() => new _DetailPageWidgetState();
}

class _DetailPageWidgetState extends State<DetailPageWidget> {
  late ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
  }

  int current_active_index = -1;
  double width_item = 100;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double main_scale = interfaces.CalculateMainScale(_width, _height);

    double _hight_top = interfaces.image_detail_part_page * main_scale;
    // interfaces.top_hight * main_scale;

    double top_1 = _hight_top +
        interfaces.top_margin_detail * main_scale +
        interfaces.best_remendec_block_height * main_scale;
    double _hight_top2 = _height - top_1;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBody: true,

        backgroundColor: interfaces.color_black,
        //  appBar: interfaces.PreferredSizeMenu(main_scale),
        // bottomNavigationBar: interfaces.FloatingNavbarBottomMenu(),

        body: Container(
          width: _width,
          height: _height,
          child: Stack(
            children: [
              Positioned(
                left: 30 * main_scale,
                top: 30 * main_scale,
                child: Container(
                    height: 40 * main_scale,
                    width: 40 * main_scale,
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: InkWell(
                      //focusColor: Colors.blue,
                      onTap: () {
                        globals.next_page = "page_3";
                        //globals.current_index = widget.index;
                        RouteNavigation(context);
                        //showCustomDialog(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.white,
                      ),
                    )),
              ),
              Positioned(
                top: interfaces.top_margin_detail * main_scale,
                child: Container(
                  height: _hight_top,
                  width: _width,
                  child: interfaces.OneDetailItem(
                      index: globals.current_index,
                      width: _width,
                      main_scale: main_scale,
                      callBack: () {
                        setState(() {});
                      }),
                ),
              ),
              Positioned(
                top: _hight_top + interfaces.top_margin_detail * main_scale,
                child: Container(
                  padding: EdgeInsets.only(left: 20 * main_scale),
                  height: interfaces.best_remendec_block_height * main_scale,
                  width: _width,
                  child: RichText(
                    textAlign: TextAlign.left,
                    textScaleFactor: 1,
                    text: TextSpan(
                      text: "You can also like" + "",
                      style: TextStyle(
                        color: interfaces.color_white,
                        fontSize: 20,
                        height: 1.8,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: top_1,
                  left: 20 * main_scale,
                  child: Container(
                    height: _hight_top2,
                    width: _width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(0),
                      child: Container(
                        child: Container(
                          margin: EdgeInsets.only(left: 20 * main_scale),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                for (int i = 0;
                                    i < globals.books.books.length;
                                    i++)
                                  //{
                                  interfaces.OneVerticalItem(
                                    index: i,
                                    need_hover: false,
                                    callBack: () {
                                      setState(() {});
                                    },
                                    current_index: current_active_index,
                                    width: _width,
                                    main_scale: main_scale,
                                  )
                              ]),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
