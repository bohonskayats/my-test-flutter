class Book {
  final String isbn;

  final String title;
  final String author;
  final String subtitle;
  final String published;
  final String publisher;
  final int pages;
  final String description;
  final String website;

  const Book({
    required this.isbn,
    required this.title,
    required this.author,
    required this.subtitle,
    required this.published,
    required this.publisher,
    required this.pages,
    required this.description,
    required this.website,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        title: json['title'],
        isbn: json['isbn'],
        author: json['author'],
        subtitle: json['subtitle'],
        published: json['published'],
        publisher: json['publisher'],
        pages: json['pages'],
        description: json['description'],
        website: json['website']);
  }

  Map<String, dynamic> tojson() => {
        "title": title,
        "isbn": isbn,
        "author": author,
        "subtitle": subtitle,
        "published": published,
        "publisher": publisher,
        "pages": pages,
        "description": description,
        "website": website
      };
}

class Books {
  List<Book> books;
  Books({
    required this.books,
  });
  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      books: (json['books'] as List).map((p) => Book.fromJson(p)).toList(),
    );
  }
}
