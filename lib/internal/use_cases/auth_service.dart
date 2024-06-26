import 'package:carnival/infastructure/exceptions/failuters.dart';
import 'package:carnival/internal/entities/auth_entity.dart';
import 'package:carnival/internal/interfaces/auth_interface.dart';
import 'package:dartz/dartz.dart';

class AuthService {
  final AuthInterface repository;

  AuthService(this.repository);

  Future<Either<Failure, AuthEntity>> authenticate(
      String username, String password) async {
    return await repository.authenticate(username, password);
  }
}
