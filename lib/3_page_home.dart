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

class HomeListPageWidget extends StatefulWidget {
  const HomeListPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  _HomeListPageWidgetState createState() => new _HomeListPageWidgetState();
}

class _HomeListPageWidgetState extends State<HomeListPageWidget> {
  late ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading = false;
      current_active_index = 0;
    });
    _scrollController = ScrollController()..addListener(() {});

    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => loadBookList());
  }

  Future<void> loadBookList() async {
    if (globals.books.books.length == 0) {
      start_loading();
      globals.books.books.clear();

      globals.books = (await loading.fetchAlbum(() {
        setState(() {
          loading.need_reload = true;
        });
      }, () {
        setState(() {
          loading.need_reload = false;
        });
      }));

      for (int i = 0; i < globals.books.books.length; i++) {
        Uint8List dd = await loading.downloadImage1(loading.url_image);
        globals.books_images.add(dd);
      }
      for (int i = 0; i < globals.books.books.length; i++) {
        globals.favorites_book.add(false);
      }
      end_loading();
      setState(() {});
    }
  }

  bool isLoading = false;
  start_loading() {
    context.loaderOverlay.show(widget: ReconnectingOverlay());
    setState(() {
      isLoading = true;
    });
  }

  end_loading() {
    if (context.loaderOverlay.overlayWidgetType == ReconnectingOverlay) {
      context.loaderOverlay.hide();
      isLoading = false;
      //
    }
  }

  int current_active_index = -1;
  double width_item = 100;
  _scrollListener() {
    double main_scale = 1;
    double r = main_scale *
        _scrollController.offset /
        interfaces.normal_list_image_width;
    setState(() {
      current_active_index = r.toInt();
    });
    /* if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        debugPrint("reach the top");
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        debugPrint("reach the top");
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double main_scale = interfaces.CalculateMainScale(_width, _height);

    double _hight_top = interfaces.big_list_image_height * main_scale;
    // interfaces.top_hight * main_scale;
    double _hight_top2 =
        _height - _hight_top - interfaces.top_menu_height * main_scale;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: interfaces.color_black,
        appBar: interfaces.PreferredSizeMenu(main_scale),
        bottomNavigationBar: interfaces.FloatingNavbarBottomMenu(),
        body: LoaderOverlay(
          overlayColor: interfaces.color_black,
          overlayOpacity: 0.3,
          child: Container(
            width: _width,
            height: _height,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: _hight_top - 10,
                    width: _width,
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: Container(
                          margin: EdgeInsets.only(left: 20 * main_scale),
                          child: Row(children: [
                            for (int i = 0; i < globals.books.books.length; i++)
                              interfaces.OneVerticalItem(
                                index: i,
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
                  ),
                ),
                if (loading.need_reload == true)
                  Positioned(
                    top: _hight_top,
                    child: Container(
                      padding: EdgeInsets.only(left: 20 * main_scale),
                      height: 60 * main_scale,
                      width: _width,
                      child: InkWell(
                        //focusColor: Colors.blue,
                        onTap: () {
                          setState(() {});
                          loadBookList();
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.refresh,
                                  size: 23,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                            text: "Reload " + "",
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
                if (loading.need_reload == false && isLoading == false)
                  Positioned(
                    top: _hight_top,
                    child: Container(
                      padding: EdgeInsets.only(left: 20 * main_scale),
                      height: 60 * main_scale,
                      width: _width,
                      child: RichText(
                        textAlign: TextAlign.left,
                        textScaleFactor: 1,
                        text: TextSpan(
                          text: "Best seller" + "",
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
                  top: _hight_top + 60 * main_scale,
                  left: 20 * main_scale,
                  child: Container(
                    height: _hight_top2 - 60 * main_scale,
                    width: _width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 15 * main_scale, bottom: 90 * main_scale),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0;
                                    i < globals.books.books.length;
                                    i++)
                                  interfaces.OneHorizontalItem(
                                    index: i,
                                    callBack: () {
                                      setState(() {});
                                    },
                                    width: _width,
                                    main_scale: main_scale,
                                  )
                              ]),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
