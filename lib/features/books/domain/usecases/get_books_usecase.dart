import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/book.dart';
import '../repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository repository;
  
  GetBooksUseCase(this.repository);
  
  Future<Either<Failure, List<Book>>> execute() async {
    return await repository.getBooks();
  }
}
