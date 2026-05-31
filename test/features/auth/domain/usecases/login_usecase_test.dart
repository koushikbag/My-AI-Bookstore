import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_ai_bookstore/core/error/failures.dart';
import 'package:my_ai_bookstore/features/auth/domain/entities/user.dart';
import 'package:my_ai_bookstore/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_ai_bookstore/features/auth/domain/usecases/login_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepository;
  
  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });
  
  const testUsername = 'Koushikbag';
  const testUser = User(username: testUsername);
  
  test('should return User when login is successful', () async {
    // arrange
    when(() => mockRepository.login(testUsername))
        .thenAnswer((_) async => const Right(testUser));
    
    // act
    final result = await useCase.execute(testUsername);
    
    // assert
    expect(result, const Right(testUser));
    verify(() => mockRepository.login(testUsername));
    verifyNoMoreInteractions(mockRepository);
  });
  
  test('should return AuthFailure when username is empty', () async {
    // act
    final result = await useCase.execute('');
    
    // assert
    expect(result, isA<Left>());
    result.fold(
      (failure) => expect(failure, isA<AuthFailure>()),
      (_) => fail('Should return failure'),
    );
    verifyZeroInteractions(mockRepository);
  });
  
  test('should return AuthFailure when repository fails', () async {
    // arrange
    when(() => mockRepository.login(testUsername))
        .thenAnswer((_) async => const Left(AuthFailure('Invalid username')));
    
    // act
    final result = await useCase.execute(testUsername);
    
    // assert
    expect(result, const Left(AuthFailure('Invalid username')));
    verify(() => mockRepository.login(testUsername));
  });
}
