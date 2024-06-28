import 'package:carnival/infastructure/exceptions/failuters.dart';
import 'package:carnival/internal/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthInterface {
  Future<Either<Failure, AuthEntity>> authenticate(
      String token);
}
