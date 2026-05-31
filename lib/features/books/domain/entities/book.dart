import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String id;
  final String title;
  final String author;
  final String publishedDate;
  final String imageUrl;
  
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.publishedDate,
    required this.imageUrl,
  });
  
  @override
  List<Object> get props => [id, title, author, publishedDate, imageUrl];
}
