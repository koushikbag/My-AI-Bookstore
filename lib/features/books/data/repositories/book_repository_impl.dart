import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/mock_book_datasource.dart';

class BookRepositoryImpl implements BookRepository {
  final MockBookDataSource dataSource;
  
  BookRepositoryImpl(this.dataSource);
  
  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    try {
      final books = await dataSource.getBooks();
      return Right(books);
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }
}
