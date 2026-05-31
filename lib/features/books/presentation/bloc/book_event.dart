import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
  
  @override
  List<Object> get props => [];
}

class LoadBooks extends BookEvent {
  const LoadBooks();
}

class RefreshBooks extends BookEvent {
  const RefreshBooks();
}
