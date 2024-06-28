

import 'package:carnival/infastructure/exceptions/failuters.dart';
import 'package:carnival/internal/entities/recommendation_entity.dart';
import 'package:carnival/internal/interfaces/recommendation_interface.dart';
import 'package:dartz/dartz.dart';

class RecommendationService{
  final RecommendationInterface recommendationRepository;

  RecommendationService(this.recommendationRepository);

  Future<Either<Failure, RecommendationEntitys>> getRecommendations(String token) async {
    return await recommendationRepository.getRecommendations(token);
  }
}