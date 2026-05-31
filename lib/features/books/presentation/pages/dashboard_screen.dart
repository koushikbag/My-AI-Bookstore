import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/datasources/mock_book_datasource.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/usecases/get_books_usecase.dart';
import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';
import '../widgets/book_list_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookBloc(
        getBooksUseCase: GetBooksUseCase(
          BookRepositoryImpl(
            MockBookDataSource(),
          ),
        ),
      )..add(const LoadBooks()),
      child: const _DashboardScreenContent(),
    );
  }
}

class _DashboardScreenContent extends StatelessWidget {
  const _DashboardScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<BookBloc>().add(const RefreshBooks());
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading books...'),
                ],
              ),
            );
          }
          
          if (state is BookError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<BookBloc>().add(const LoadBooks());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          
          if (state is BookLoaded) {
            if (state.books.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text('No books available'),
                  ],
                ),
              );
            }
            
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BookBloc>().add(const RefreshBooks());
                // Wait for the refresh to complete
                await Future.delayed(const Duration(milliseconds: 500));
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.defaultPadding,
                ),
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  return BookListItem(book: state.books[index]);
                },
              ),
            );
          }
          
          return const Center(
            child: Text('Welcome to My AI Bookstore'),
          );
        },
      ),
    );
  }
}
