import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_ai_bookstore/core/error/failures.dart';
import 'package:my_ai_bookstore/features/books/domain/entities/book.dart';
import 'package:my_ai_bookstore/features/books/domain/repositories/book_repository.dart';
import 'package:my_ai_bookstore/features/books/domain/usecases/get_books_usecase.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  late GetBooksUseCase useCase;
  late MockBookRepository mockRepository;
  
  setUp(() {
    mockRepository = MockBookRepository();
    useCase = GetBooksUseCase(mockRepository);
  });
  
  final testBooks = [
    const Book(
      id: '1',
      title: 'Test Book 1',
      author: 'Author 1',
      publishedDate: '2020-01-01',
      imageUrl: 'https://example.com/image1.jpg',
    ),
    const Book(
      id: '2',
      title: 'Test Book 2',
      author: 'Author 2',
      publishedDate: '2021-01-01',
      imageUrl: 'https://example.com/image2.jpg',
    ),
  ];
  
  test('should return list of books when repository call is successful', () async {
    // arrange
    when(() => mockRepository.getBooks())
        .thenAnswer((_) async => Right(testBooks));
    
    // act
    final result = await useCase.execute();
    
    // assert
    expect(result, Right(testBooks));
    verify(() => mockRepository.getBooks());
    verifyNoMoreInteractions(mockRepository);
  });
  
  test('should return DataFailure when repository fails', () async {
    // arrange
    when(() => mockRepository.getBooks())
        .thenAnswer((_) async => const Left(DataFailure('Failed to load books')));
    
    // act
    final result = await useCase.execute();
    
    // assert
    expect(result, const Left(DataFailure('Failed to load books')));
    verify(() => mockRepository.getBooks());
  });
}
