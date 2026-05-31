import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_books_usecase.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBooksUseCase getBooksUseCase;
  
  BookBloc({required this.getBooksUseCase}) : super(const BookInitial()) {
    on<LoadBooks>(_onLoadBooks);
    on<RefreshBooks>(_onRefreshBooks);
  }
  
  Future<void> _onLoadBooks(
    LoadBooks event,
    Emitter<BookState> emit,
  ) async {
    emit(const BookLoading());
    
    final result = await getBooksUseCase.execute();
    
    result.fold(
      (failure) => emit(BookError(failure.message)),
      (books) => emit(BookLoaded(books)),
    );
  }
  
  Future<void> _onRefreshBooks(
    RefreshBooks event,
    Emitter<BookState> emit,
  ) async {
    // Keep current state while refreshing
    final result = await getBooksUseCase.execute();
    
    result.fold(
      (failure) => emit(BookError(failure.message)),
      (books) => emit(BookLoaded(books)),
    );
  }
}
