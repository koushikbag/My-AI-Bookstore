import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/book_model.dart';

class MockBookDataSource {
  Future<List<BookModel>> getBooks() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    try {
      final String response = await rootBundle.loadString('assets/mock_data/books.json');
      final Map<String, dynamic> data = json.decode(response);
      final List<dynamic> booksJson = data['books'];
      
      return booksJson.map((json) => BookModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load books: $e');
    }
  }
}
