import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'sources/ReconnectingOverlay.dart';
import 'sources/custom_button.dart';
import 'sources/globals.dart' as globals;
import 'sources/interface.dart' as interfaces;
import 'sources/keyboard.dart';
import 'sources/loading.dart' as loading;
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'sources/loading.dart';
import 'sources/navigation.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageWidgetState createState() => new _LoginPageWidgetState();
}

enum FormType { login, register }

class _LoginPageWidgetState extends State<LoginPageWidget> {
  String _email = "";
  String _password = "";
  FormType _formType = FormType.login;
  String _authHint = '';
//error_login
  void loginSubmit() async {
    FocusScope.of(context).unfocus();
    if (valideDataLogin()) {
      setState(() {
        error_login = false;
      });
      await start_loading();
    } else {
      setState(() {
        error_login = true;
      });
    }
  }

  late TextEditingController _controller_email;

  late TextEditingController _controller_password;
  bool _passwordVisible = false;
  late double _border_radius = 1684; //* main_scale;
  late int _pressedColor = 0xdeadbeef;
  final KeyboardBloc _bloc = KeyboardBloc();
  bool isVisibleKeyboard = false;
  resetKey() {
    setState(() {
      isVisibleKeyboard = true;
    });
  }

  resetKey2() {
    setState(() {
      isVisibleKeyboard = false;
    });
  }

  var keyboardVisibilityController;

  setData() async {
    setState(() {
      _email = "";
      _password = "";
      _controller_email.text = _email;
      _controller_password.text = _password;
    });
  }

  bool valideDataLogin() {
    if (_email == "" || _password == "") return false;
    return true;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _email = "";
      _password = "";
    });

    _bloc.start(() {
      setState(() {
        isVisibleKeyboard = true;
      });
    }, () {
      setState(() {
        isVisibleKeyboard = false;
      });
    });
    keyboardVisibilityController = KeyboardVisibilityController();
    setData();
    _controller_email = new TextEditingController(text: _email);

    _controller_password = new TextEditingController(text: _password);

    _controller_password.addListener(_catchPasswordValue);
    _controller_email.addListener(_catchEmailtValue);
  }

  void _catchEmailtValue() {
    _email = _controller_email.text;
  }

  void _catchPasswordValue() {
    _password = _controller_password.text;
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

/////////
  List<Widget> usernameAndPassword(double main_scale) {
    double icon_size_hide = 15;
    double icon_size_lock_w = 21;
    double icon_size_lock_h = 21;
    double icon_size_email_w = 21;
    double icon_size_email_h = 21;
    double icon_padding = 10;

    double button_w = interfaces.button_login_w * main_scale;
    double button_h = interfaces.button_login_h * main_scale;

    return [
      //------------------------------------email START

      Container(
        margin: EdgeInsets.fromLTRB(
            0, interfaces.margin_between_button * main_scale * 0, 0, 0),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1,
          ),
          child: SizedBox(
            height: button_h,
            width: button_w,
            child: TextField(
              maxLines: 1,
              key: const Key('email'),
              controller: _controller_email,
              style: TextStyle(
                  height: 2,
                  color: interfaces.normal_login_text,
                  fontSize: interfaces.font_size,
                  fontFamily: interfaces.general_main_font),
              decoration: InputDecoration(
                filled: true,
                fillColor: interfaces.button_login_bg,
                //interfaces.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_border_radius)),
                  borderSide: BorderSide(
                      width: 1,
                      color: interfaces.button_login_border_noneactive),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_border_radius)),
                  borderSide: BorderSide(
                      width: 1, color: interfaces.button_login_border_active),
                ),
                isDense: true,
                hintText: "Email",
                hintStyle: TextStyle(
                    fontSize: interfaces.font_size,
                    color: interfaces.hint_login_text),
                prefixIconConstraints: BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                    maxHeight: icon_size_lock_h,
                    maxWidth: icon_size_lock_w + icon_padding * 2),
              ),
            ),
          ),
        ),
      ),
      //------------------------------------PASSWORD START

      Container(
        margin: EdgeInsets.fromLTRB(
            0, interfaces.margin_between_button * main_scale, 0, 0),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1,
          ),
          child: SizedBox(
            height: button_h,
            width: button_w,
            child: TextField(
              maxLines: 1,
              key: const Key('password'),
              controller: _controller_password,

              obscureText: !_passwordVisible,
              style: TextStyle(
                  height: 2,
                  color: interfaces.normal_login_text,
                  fontSize: interfaces.font_size /*/ _textScale*/,
                  fontFamily: interfaces.general_main_font),

              decoration: InputDecoration(
                filled: true,
                fillColor: interfaces.button_login_bg,
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_border_radius)),
                  borderSide: BorderSide(
                      width: 1,
                      color: interfaces.button_login_border_noneactive),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_border_radius)),
                  borderSide: BorderSide(
                      width: 1, color: interfaces.button_login_border_active),
                ),
                hintText: "Mot de passe",
                hintStyle: TextStyle(
                    fontSize: interfaces.font_size,
                    color: interfaces.hint_login_text),
                suffixIcon: IconButton(
                  padding:
                      EdgeInsetsDirectional.only(end: 0, start: icon_padding),
                  iconSize: 15,
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: interfaces.normal_login_text,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                isDense: true,
                prefixIconConstraints: BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                    maxHeight: icon_size_lock_h,
                    maxWidth: icon_size_lock_w + icon_padding * 2),
              ),

              //------------------------------------PASSWORD END
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> submitWidgets(double main_scale) {
    return [
      Container(
        width: interfaces.button_login_w * main_scale,
        // height: interfaces.button_login_h * main_scale,
        margin:
            EdgeInsets.only(top: interfaces.margin_between_button * main_scale),
        child: CustomButtonWidget(
            key: _myWidgetState_from,
            height: interfaces.button_login_h * main_scale,
            width: interfaces.button_login_w * main_scale,
            text_name: "Connexion".toUpperCase(),
            font_size: interfaces.font_size,
            callback: () {
              loginSubmit();
            }),
      ),
    ];
  }

  List<Widget> TitleWidgetLogin(double main_scale) {
    return [
      SizedBox(
        height: isVisibleKeyboard
            ? interfaces.logo_hight_small * main_scale
            : interfaces.logo_hight_big * main_scale,
        child: SvgPicture.asset(
          interfaces.logo,
          fit: BoxFit.contain,
          matchTextDirection: true,
        ),
      ),
    ];
  }

  List<Widget> ErrorWidgetLogin(double main_scale, bool error) {
    if (error == false) {
      return [
        Container(
          height: interfaces.height_error_block * main_scale,
          margin: EdgeInsets.only(
              top: main_scale * interfaces.margin_between_button,
              left: 0 * main_scale),
        ),
      ];
    }
    return [
      Container(
        margin: EdgeInsets.only(
            top: main_scale * interfaces.margin_between_button,
            left: 0 * main_scale),
        height: interfaces.height_error_block * main_scale,
        child: RichText(
          textAlign: TextAlign.left,
          textScaleFactor: interfaces.textFactor,
          text: TextSpan(
            text: FormType.register == _formType
                ? ""
                : error == true
                    ? "Логин или пароль неверны"
                    : "",
            style: TextStyle(
                color: interfaces.error_text,
                fontSize: interfaces.font_size,
                height: 1,
                fontFamily: interfaces.general_main_font),
          ),
        ),
      ),
    ];
  }

  start_loading() async {
    context.loaderOverlay.show(widget: ReconnectingOverlay());

    await Future.delayed(const Duration(milliseconds: 1000), () {
      end_loading();
      globals.next_page = "page_3";
      RouteNavigation(context);
    });
  }

  end_loading() async {
    if (context.loaderOverlay.overlayWidgetType == ReconnectingOverlay) {
      context.loaderOverlay.hide();

      //
    }
  }

  final GlobalKey<state_CustomButtonWidget> _myWidgetState_from =
      GlobalKey<state_CustomButtonWidget>();
  final GlobalKey<state_CustomButtonWidget> _myWidgetState_to =
      GlobalKey<state_CustomButtonWidget>();
  bool error_login = false;
  bool before_main_loading_show_bg = false;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    double main_scale = interfaces.CalculateMainScale(_width, _height);

    double b_w = interfaces.button_login_h * main_scale;
    double b_h = interfaces.button_login_h * main_scale;

    double button_width = _width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: interfaces.color_black,
        body: Container(
          height: _height,
          width: _width,
          color: interfaces.color_black,
          child: LoaderOverlay(
            overlayColor: interfaces.loader_overlay_color,
            overlayOpacity: 0.3,
            child: Center(
              child: Stack(
                children: [
                  Align(
                    alignment: isVisibleKeyboard
                        ? Alignment.topCenter
                        : Alignment.center,
                    child: Container(
                      height: interfaces.block_login_height * main_scale,
                      margin: EdgeInsets.only(
                        top: 40 * main_scale,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: TitleWidgetLogin(main_scale) +
                              ErrorWidgetLogin(main_scale, error_login) +
                              usernameAndPassword(main_scale) +
                              submitWidgets(main_scale) //+
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
