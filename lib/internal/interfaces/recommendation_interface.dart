

import 'package:carnival/infastructure/exceptions/failuters.dart';
import 'package:carnival/internal/entities/recommendation_entity.dart';
import 'package:dartz/dartz.dart';

abstract class RecommendationInterface {
  Future<Either<Failure, RecommendationEntitys>> getRecommendations(String token);
}
