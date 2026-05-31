import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_ai_bookstore/core/error/failures.dart' as failures;
import 'package:my_ai_bookstore/features/auth/domain/entities/user.dart';
import 'package:my_ai_bookstore/features/auth/domain/usecases/login_usecase.dart';
import 'package:my_ai_bookstore/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:my_ai_bookstore/features/auth/presentation/bloc/auth_event.dart';
import 'package:my_ai_bookstore/features/auth/presentation/bloc/auth_state.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late AuthBloc bloc;
  late MockLoginUseCase mockLoginUseCase;
  
  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    bloc = AuthBloc(loginUseCase: mockLoginUseCase);
  });
  
  tearDown(() {
    bloc.close();
  });
  
  const testUsername = 'Koushikbag';
  const testUser = User(username: testUsername);
  
  test('initial state should be AuthInitial', () {
    expect(bloc.state, const AuthInitial());
  });
  
  group('LoginRequested', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthSuccess] when login is successful',
      build: () {
        when(() => mockLoginUseCase.execute(testUsername))
            .thenAnswer((_) async => const Right(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoginRequested(testUsername)),
      expect: () => [
        const AuthLoading(),
        const AuthSuccess(testUser),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase.execute(testUsername)).called(1);
      },
    );
    
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthFailure] when login fails',
      build: () {
        when(() => mockLoginUseCase.execute(testUsername))
            .thenAnswer((_) async => const Left(failures.AuthFailure('Invalid username')));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoginRequested(testUsername)),
      expect: () => [
        const AuthLoading(),
        const AuthFailure('Invalid username'),
      ],
    );
  });
  
  group('LogoutRequested', () {
    blocTest<AuthBloc, AuthState>(
      'should emit AuthUnauthenticated when logout is requested',
      build: () => bloc,
      act: (bloc) => bloc.add(const LogoutRequested()),
      expect: () => [const AuthUnauthenticated()],
    );
  });
}
