import 'data_structeres.dart';

String next_page = "";
int current_index = -1;
Books books = Books(books: []);
//I decide to use another array for images because I get media data from diffent sources
//I think this app did not have so much datas  that is why i decide to load data once
////  when user open app
List<dynamic> books_images = [];
List<bool> favorites_book = [];

bool getIconFavorite(int index) {
  if (favorites_book != null && favorites_book.length > index) {
    return favorites_book.elementAt(index);
  }
  return false;
}

bool changeIconFavorite(int index) {
  if (favorites_book != null && favorites_book.length > index) {
    favorites_book[index] = !favorites_book.elementAt(index);

    return true;
  }
  return false;
}
