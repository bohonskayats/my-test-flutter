import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'globals.dart' as globals;
import 'interface.dart' as interfaces;

class CustomButtonWidget extends StatefulWidget {
  final String text_name;
  final double width;
  final double height;
  final double font_size; // = 18;
  final VoidCallback callback;
  const CustomButtonWidget(
      {Key? key,
      required this.text_name,
      this.width = 203,
      this.height = 53,
      required this.callback,
      this.font_size = 18})
      : super(key: key);

  @override
  State<CustomButtonWidget> createState() =>
      state_CustomButtonWidget(text_name, width, height, callback, font_size);
}

class state_CustomButtonWidget extends State<CustomButtonWidget>
    with TickerProviderStateMixin {
  String _text_name;
  double _width;
  double _height;
  double _font_size;
  // MyEventCallback _callback;
  VoidCallback _callback;

  state_CustomButtonWidget(this._text_name, this._width, this._height,
      this._callback, this._font_size);

  void initState() {
    super.initState();
    _width = widget.width;
    _height = widget.height;
    _callback = widget.callback;
    _font_size = widget.font_size;
    setValue();
  }

  method() {}

  setValue() {}

  @override
  Widget build(BuildContext context) {
    double textScale = 1;

    double _button_w = _width;
    double _button_h = _height;

    return Container(
      width: _button_w,
      height: _button_h,

      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: InkWell(
          //   customBorder: new CircleBorder( side:BorderSide.none),
          onTap: () {
            _callback();
          },
          child: Container(
            width: _button_w,
            height: _button_h,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  width: _button_w,
                  height: _button_h,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: interfaces.button_bg,
                      ),
                      color: interfaces.button_bg,
                      borderRadius: BorderRadius.all(
                          Radius.circular(interfaces.button_login_h / 2))),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: _button_w,
                    height: _button_h,
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: _text_name,
                          style: TextStyle(
                              color: interfaces.button_text,
                              fontSize: _font_size,
                              height: 1,
                              fontFamily: interfaces.general_main_font),
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
      //  ), //),
    );
    // }
  }
}
