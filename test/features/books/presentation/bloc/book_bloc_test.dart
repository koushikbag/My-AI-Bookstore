import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_ai_bookstore/core/error/failures.dart';
import 'package:my_ai_bookstore/features/books/domain/entities/book.dart';
import 'package:my_ai_bookstore/features/books/domain/usecases/get_books_usecase.dart';
import 'package:my_ai_bookstore/features/books/presentation/bloc/book_bloc.dart';
import 'package:my_ai_bookstore/features/books/presentation/bloc/book_event.dart';
import 'package:my_ai_bookstore/features/books/presentation/bloc/book_state.dart';

class MockGetBooksUseCase extends Mock implements GetBooksUseCase {}

void main() {
  late BookBloc bloc;
  late MockGetBooksUseCase mockGetBooksUseCase;
  
  setUp(() {
    mockGetBooksUseCase = MockGetBooksUseCase();
    bloc = BookBloc(getBooksUseCase: mockGetBooksUseCase);
  });
  
  tearDown(() {
    bloc.close();
  });
  
  final testBooks = [
    const Book(
      id: '1',
      title: 'Test Book',
      author: 'Test Author',
      publishedDate: '2020-01-01',
      imageUrl: 'https://example.com/image.jpg',
    ),
  ];
  
  test('initial state should be BookInitial', () {
    expect(bloc.state, const BookInitial());
  });
  
  group('LoadBooks', () {
    blocTest<BookBloc, BookState>(
      'should emit [BookLoading, BookLoaded] when books are loaded successfully',
      build: () {
        when(() => mockGetBooksUseCase.execute())
            .thenAnswer((_) async => Right(testBooks));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadBooks()),
      expect: () => [
        const BookLoading(),
        BookLoaded(testBooks),
      ],
      verify: (_) {
        verify(() => mockGetBooksUseCase.execute()).called(1);
      },
    );
    
    blocTest<BookBloc, BookState>(
      'should emit [BookLoading, BookError] when loading books fails',
      build: () {
        when(() => mockGetBooksUseCase.execute())
            .thenAnswer((_) async => const Left(DataFailure('Failed to load books')));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadBooks()),
      expect: () => [
        const BookLoading(),
        const BookError('Failed to load books'),
      ],
    );
  });
  
  group('RefreshBooks', () {
    blocTest<BookBloc, BookState>(
      'should emit BookLoaded when books are refreshed successfully',
      build: () {
        when(() => mockGetBooksUseCase.execute())
            .thenAnswer((_) async => Right(testBooks));
        return bloc;
      },
      act: (bloc) => bloc.add(const RefreshBooks()),
      expect: () => [BookLoaded(testBooks)],
    );
  });
}
