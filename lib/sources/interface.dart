import 'dart:ui';

double orid_w = 414;
double orid_h = 896;

String logo = "assets/svg/logo.svg";

const Color color_black = Color(0xff130C23);
Color transparent = const Color(0x00000000);

const Color color_gray_1 = Color(0xff3C3B4B);
const Color color_light_gray_1 = Color(0xffF2F2F2);
const Color color_light_gray_2 = Color(0xff84848B);
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

double textFactor = 1;

int delay_01 = 1000;
int delay_02 = 0;

String general_main_font = 'Roboto';

double CalculateMainScale(double w, double h) {
  double main_scale_w = w / orid_w;
  double main_scale_h = h / orid_h;

  //if (main_scale_w < main_scale_h) return main_scale_w;

  return main_scale_w;
}
