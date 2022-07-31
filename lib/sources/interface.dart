import 'dart:ui';

import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'interface.dart' as interfaces;
import 'globals.dart' as globals;

double orid_w = 414;
double orid_h = 896;

String logo = "assets/svg/logo.svg";
String logo_mini = "assets/svg/logo_mini.svg";

const Color color_black = Color(0xff130C23);
const Color color_white = Color(0xffffffff);

Color transparent = const Color(0x00000000);

const Color color_gray_1 = Color(0xff3C3B4B);
const Color color_white_semi_transpanrent = Color(0x88ffffff);
const Color color_gray_semi_transpanrent = Color(0xcc555555);

const Color color_light_gray_1 = Color(0xffF2F2F2);
const Color color_light_gray_2 = Color(0xff84848B);
const Color color_light_gray_3 = Color(0xff8484bb);

const Color color_violet = Color(0xff4838D1);
const Color color_red = Color(0xff990000);

const Color button_bg = color_light_gray_1;
const Color input_bg = color_light_gray_2;
const Color loader_color = color_violet;
const Color loader_overlay_color = color_violet;

const Color button_login_bg = color_gray_1;

const Color button_login_border_active = color_light_gray_2;
const Color button_login_border_noneactive = color_gray_1;
const Color hint_login_text = color_light_gray_2;
const Color normal_login_text = color_light_gray_1;
const Color button_text = color_gray_1;

const Color error_text = color_red;

const Color bg_dot_menu = color_gray_semi_transpanrent;
const Color active_item_dot_menu = color_light_gray_1;
const Color unctive_item_dot_menu = color_light_gray_2;

double font_size = 17;
double button_login_h = 60;
double button_login_w = 320;
double height_error_block = 20;
double margin_between_button = 20;
double logo_hight_big = 150;
double logo_hight_small = 80;

double button_width = 40;
double button_height = 40;

double block_login_height = margin_between_button * 5 +
    button_login_h * 3 +
    logo_hight_big +
    height_error_block;

double normal_list_image_width = 120;
double normal_list_image_height = 180;

double vertical_list_image_width = 90;
double vertical_list_image_height = 120;

double big_list_image_width = normal_list_image_width * 1.5;
double big_list_image_height = normal_list_image_height * 1.5;
/*
double normal_top_block_width = normal_list_image_width * 1.4;
double normal_top_block_height = normal_list_image_height * 1.4;

double big_top_block_width = big_list_image_width * 1.4;
double big_top_block_height = big_list_image_height * 1.4;
*/
double textFactor = 1;

int delay_01 = 1000;
int delay_02 = 0;

double top_hight = 200;
const double top_menu_height = 100;
String general_main_font = 'Roboto';

double CalculateMainScale(double w, double h) {
  double main_scale_w = w / orid_w;
  double main_scale_h = h / orid_h;

  //if (main_scale_w < main_scale_h) return main_scale_w;

  return main_scale_w;
}

class OneHorizontalItem extends StatefulWidget {
  final int index;
  final double main_scale;
  final double width;

  const OneHorizontalItem(
      {Key? key,
      required this.index,
      required this.main_scale,
      required this.width})
      : super(key: key);

  @override
  _OneHorizontalItemState createState() => _OneHorizontalItemState();
}

class _OneHorizontalItemState extends State<OneHorizontalItem> {
  double getWidthV(int i) {
    return interfaces.vertical_list_image_width;
  }

  double getHeighV(int i) {
    return interfaces.vertical_list_image_height;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: getHeighV(widget.index),
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: getWidthV(widget.index),
              height: getHeighV(widget.index),
              child: Container(
                child: globals.books_images.length > widget.index
                    ? FittedBox(
                        fit: BoxFit.fill,
                        child: Image.memory(
                          globals.books_images.elementAt(widget.index),
                          fit: BoxFit.fill,
                        ),
                      )
                    : Container(),
              ),
            ),
          ),
          Positioned(
            top: (0) * widget.main_scale,
            left: getWidthV(widget.index) * widget.main_scale + 20,
            child: Container(
              width: (widget.width - getWidthV(widget.index) - 60) *
                  widget.main_scale,
              padding: EdgeInsets.only(bottom: 60),
              child: RichText(
                textAlign: TextAlign.left,
                textScaleFactor: 1,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: globals.books.books.elementAt(widget.index).author,
                      style: TextStyle(
                        color: interfaces.color_light_gray_3,
                        fontSize: 16,
                        height: 1.2,
                      ),
                    ),
                  ],
                  text:
                      globals.books.books.elementAt(widget.index).title + "\n",
                  style: TextStyle(
                    color: interfaces.color_light_gray_2,
                    fontSize: 22,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: (0) * widget.main_scale,
            left: getWidthV(widget.index) * widget.main_scale + 20,
            child: BookmarkRound(
              index: widget.index,
            ),
          ),
        ],
      ),
    );
  }
}

//--------------------------

class OneVerticalItem extends StatefulWidget {
  final int index;
  final int current_index;

  final double main_scale;
  final double width;

  const OneVerticalItem(
      {Key? key,
      required this.index,
      required this.current_index,
      required this.main_scale,
      required this.width})
      : super(key: key);

  @override
  _OneVerticalItemState createState() => _OneVerticalItemState();
}

class _OneVerticalItemState extends State<OneVerticalItem> {
  double getWidth(int i) {
    if (i == widget.current_index) {
      return interfaces.big_list_image_width;
    } else
      return interfaces.normal_list_image_width;
  }

  double getHeigh(int i) {
    //  if (i == widget.current_index) {
    return interfaces.big_list_image_height - 25;
    //  } else
    //    return interfaces.normal_list_image_height;
  }

  double getHeighImage(int i) {
    if (i == widget.current_index) {
      return interfaces.big_list_image_height - 25;
    } else
      return interfaces.normal_list_image_height - 20;
  }

  double getWidthV(int i) {
    return interfaces.vertical_list_image_width;
  }

  double getHeighV(int i) {
    return interfaces.vertical_list_image_height;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: getWidth(widget.index) * widget.main_scale,
      height: getHeighImage(widget.index) * widget.main_scale,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: getWidth(widget.index) * widget.main_scale,
              height: getHeighImage(widget.index) * widget.main_scale,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  child: globals.books_images.length > widget.index
                      ? FittedBox(
                          fit: BoxFit.cover,
                          child: Image.memory(
                            globals.books_images.elementAt(widget.index),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: (10) * widget.main_scale,
            right: 10 * widget.main_scale,
            child: interfaces.BookmarkRound(
              index: widget.index,
            ),
          ),
        ],
      ),
    );
  }
}

class BookmarkRound extends StatefulWidget {
  final int index;

  const BookmarkRound({Key? key, required this.index}) : super(key: key);

  @override
  _BookmarkRoundState createState() => _BookmarkRoundState();
}

class _BookmarkRoundState extends State<BookmarkRound> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //focusColor: Colors.blue,
      onTap: () {
        print(">>>");
        setState(() {
          globals.changeIconFavorite(widget.index);
        });
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: globals.getIconFavorite(widget.index)
              ? interfaces.color_white
              : interfaces.bg_dot_menu,

          // interfaces.bg_dot_menu,
        ),
        child: Icon(
          Icons.bookmark,
          size: 18,
          color: globals.getIconFavorite(widget.index)
              ? interfaces.color_gray_1
              : Colors.white,
        ),
      ),
    );
  }
}

class AppBarContent extends StatelessWidget {
  const AppBarContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double main_scale = interfaces.CalculateMainScale(_width, _height);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            height: interfaces.top_menu_height * main_scale,
            //color: Colors.blue,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SvgPicture.asset(
                    interfaces.logo_mini,
                    height: 30 * main_scale,
                    fit: BoxFit.contain,
                    matchTextDirection: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//------

PreferredSize PreferredSizeMenu(double main_scale) {
  return PreferredSize(
    preferredSize: Size.fromHeight(interfaces.top_menu_height * main_scale),
    child: Container(
      child: const interfaces.AppBarContent(),
    ),
  );
}

class FloatingNavbarBottomMenu extends StatefulWidget {
  const FloatingNavbarBottomMenu({Key? key}) : super(key: key);

  @override
  _FloatingNavbarBottomMenuState createState() =>
      _FloatingNavbarBottomMenuState();
}

enum _SelectedTab { home, favorite, search, person }

class _FloatingNavbarBottomMenuState extends State<FloatingNavbarBottomMenu> {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingNavbar(
      width: 160,
      onTap: (int val) => _handleIndexChanged,
      // backgroundColor: Colors.transparent,
      backgroundColor: interfaces.bg_dot_menu,
      selectedBackgroundColor: interfaces.transparent,
      selectedItemColor: interfaces.active_item_dot_menu,
      unselectedItemColor: interfaces.unctive_item_dot_menu,
      borderRadius: 80,
      elevation: 0,
      currentIndex: _SelectedTab.values.indexOf(_selectedTab),
      items: [
        FloatingNavbarItem(
          icon: Icons.book_sharp,
        ),
        FloatingNavbarItem(
          icon: Icons.bookmark,
        ),
      ],
      //),
    );
  }
}
