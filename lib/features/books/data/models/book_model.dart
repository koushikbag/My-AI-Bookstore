import '../../domain/entities/book.dart';

class BookModel extends Book {
  const BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.publishedDate,
    required super.imageUrl,
  });
  
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      publishedDate: json['publishedDate'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'publishedDate': publishedDate,
      'imageUrl': imageUrl,
    };
  }
}
