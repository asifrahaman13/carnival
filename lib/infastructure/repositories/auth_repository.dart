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
}