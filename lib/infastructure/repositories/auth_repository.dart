import 'package:carnival/infastructure/exceptions/failuters.dart';
import 'package:carnival/internal/entities/auth_entity.dart';
import 'package:carnival/internal/interfaces/auth_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository implements AuthInterface {
  @override
  Future<Either<Failure, AuthEntity>> authenticate(String token) async {
    try {
      final response = await http.post(
        Uri.parse('https://tb440s3n-8000.inc1.devtunnels.ms/auth/google'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final authEntity = AuthEntity.fromJson(jsonResponse);
        return Right(authEntity);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UserEntity>> validateUser(String token) async {
  try {
    final response = await http.post(
      Uri.parse('https://tb440s3n-8000.inc1.devtunnels.ms/auth/decode_token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': token,
      }),
    );

    print('############################# The body $response.body');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final userEntity = UserEntity.fromJson(jsonResponse);
      print('############################# The user entity $userEntity');
      return Right(userEntity); // Return success with userEntity
    } else {
      // Handle non-200 status code
      print('#################################### Server returned status code ${response.statusCode}');
      return Left(ServerFailure()); // Return failure
    }
  } catch (e) {
    // Handle exceptions
    print("Exception during request: $e");
    return Left(ServerFailure()); // Return failure
  }
}

}
