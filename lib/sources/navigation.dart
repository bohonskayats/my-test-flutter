import 'package:flutter/material.dart';
import 'package:flutterrecruitmenttest/4_page_detail.dart';
import 'package:flutterrecruitmenttest/5_page_favourite.dart';

import '../2_page_login.dart';
import '../3_page_home.dart';
import 'globals.dart' as globals;
import 'interface.dart' as interfaces;
import 'package:page_transition/page_transition.dart';

RouteNavigation(BuildContext context) {
  if (globals.next_page == "page_2") {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: LoginPageWidget(),
          duration: Duration(milliseconds: interfaces.delay_01),
          reverseDuration: Duration(milliseconds: interfaces.delay_02),
        ));
  } else if (globals.next_page == "page_3") {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: HomeListPageWidget(),
          duration: Duration(milliseconds: interfaces.delay_01),
          reverseDuration: Duration(milliseconds: interfaces.delay_02),
        ));
  } else if (globals.next_page == "page_5") {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: FavouritePageWidget(),
          duration: Duration(milliseconds: interfaces.delay_01),
          reverseDuration: Duration(milliseconds: interfaces.delay_02),
        ));
  } else if (globals.next_page == "page_4") {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: DetailPageWidget(),
          duration: Duration(milliseconds: interfaces.delay_01),
          reverseDuration: Duration(milliseconds: interfaces.delay_02),
        ));
  }
}
