import 'package:carnival/infastructure/exceptions/failuters.dart';
import 'package:carnival/internal/entities/auth_entity.dart';
import 'package:carnival/internal/interfaces/auth_interface.dart';
import 'package:dartz/dartz.dart';

class AuthRepository implements AuthInterface {
  @override
  Future<Either<Failure, AuthEntity>> authenticate(String username, String password) async {
    try {
      // Implement your authentication logic here, e.g., an HTTP call
      const token = "fake_token"; // Replace with actual token
      return Right(AuthEntity(token: token));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
