import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String username);
  Future<Either<Failure, User?>> getCurrentUser();
  Future<Either<Failure, void>> logout();
}
