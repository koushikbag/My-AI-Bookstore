import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  
  LoginUseCase(this.repository);
  
  Future<Either<Failure, User>> execute(String username) async {
    if (username.trim().isEmpty) {
      return const Left(AuthFailure('Username cannot be empty'));
    }
    return await repository.login(username);
  }
}
