import 'dart:convert';

import 'package:carnival/infastructure/exceptions/failuters.dart';
import 'package:carnival/internal/entities/recommendation_entity.dart';
import 'package:carnival/internal/interfaces/recommendation_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RecommendationRepository implements RecommendationInterface {
  final String? _backendUri = dotenv.env['BACKEND_URI'];

  @override
  Future<Either<Failure, RecommendationEntitys>> getRecommendations(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_backendUri/data/recommendations/$token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final RecommendationEntitys recommendations = RecommendationEntitys.fromJson(jsonResponse['recommendations']);
        return Right(recommendations);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
