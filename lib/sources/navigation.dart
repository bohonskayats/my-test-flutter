import 'package:flutter/material.dart';

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
  }

  /* else if (globals.next_page == "page_2_login") {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: LoginPageWidget(
          is_login: globals.is_login_page,
        ),
        duration: Duration(milliseconds: interfaces.delay_01),
        reverseDuration: Duration(milliseconds: interfaces.delay_02),
      ),
    );
  } else if (globals.next_page == "page_3") {
    globals.next_page = globals.cur_page;
    globals.cur_page = "page_3";

    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: AllListScreenFoldersWidget(),
          duration: Duration(milliseconds: interfaces.delay_1),
          reverseDuration: Duration(milliseconds: interfaces.delay_2),
        ));
  } else if (globals.next_page == "page_4") {
    globals.next_page = globals.cur_page;
    globals.cur_page = "page_4";

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: CategoryWidget(),
        duration: Duration(milliseconds: interfaces.delay_1),
        reverseDuration: Duration(milliseconds: interfaces.delay_2),
      ),
    );
  } else if (globals.next_page == "page_subscription_code") {
  } else if (globals.next_page == "page_5_category_item") {
    globals.next_page = globals.cur_page;
    globals.cur_page = "page_5_category_item";

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: CategoryItemWidget(),
        duration: Duration(milliseconds: interfaces.delay_1),
        reverseDuration: Duration(milliseconds: interfaces.delay_2),
      ),
    );
  } else if (globals.next_page == "page_5_category_item_description") {
    globals.next_page = globals.cur_page;
    globals.cur_page = "page_5_category_item_description";

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: CategoryItemDescriptionWidget(),
        duration: Duration(milliseconds: interfaces.delay_1),
        reverseDuration: Duration(milliseconds: interfaces.delay_2),
      ),
    );
  } else if (globals.next_page == "page_5_audio") {
    String name1 = globals.getCurrentCourseId();

    if (name1 == "") {
      interfaces.showNoMailAppsDialog(context, "Вы не выбрали курс еще");
    } else {
      globals.next_page = globals.cur_page;
      globals.cur_page = "page_5_audio";

      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: AudioPlayerWidget(),
          duration: Duration(milliseconds: /*interfaces.delay_1*/ 1000),
          reverseDuration: Duration(milliseconds: /*interfaces.delay_2*/ 1000),
        ),
      );
    }
  } else if (globals.next_page == "page_5_question") {
    globals.next_page = globals.cur_page;
    globals.cur_page = "page_5_question";

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: QuestionWidget(),
        duration: Duration(milliseconds: interfaces.delay_1),
        reverseDuration: Duration(milliseconds: interfaces.delay_2),
      ),
    );
  } else if (globals.next_page == "page_6") {
    globals.next_page = globals.cur_page;
    globals.cur_page = "page_6";

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: MyCoursesWidget(),
        duration: Duration(milliseconds: interfaces.delay_1),
        reverseDuration: Duration(milliseconds: interfaces.delay_2),
      ),
    );
  } else if (globals.next_page == "page_7") {
    globals.next_page = globals.cur_page;
    globals.cur_page = "page_7";

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: SettingsWidget(),
        duration: Duration(milliseconds: interfaces.delay_1),
        reverseDuration: Duration(milliseconds: interfaces.delay_2),
      ),
    );
  } else if (globals.next_page == "page_5a") {
  } else if (globals.next_page == "page_6") {
  } else if (globals.next_page == "page_1_login") {
    globals.next_page = "page_3";
  } else if (globals.next_page == "page_1_promo_code") {
    globals.next_page = "page_3";
  } else if (globals.next_page == "page_1") {
  } else if (globals.next_page == "page_9") {
    globals.next_page = "page_1_login";
  }*/
}
