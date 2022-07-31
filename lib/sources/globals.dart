import 'data_structeres.dart';

String next_page = "";
int current_index = -1;
Books books = Books(books: []);
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
