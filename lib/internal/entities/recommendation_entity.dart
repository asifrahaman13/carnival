class RecommendationEntity {
  String title;
  String details;

  RecommendationEntity({
    required this.title,
    required this.details,
  });

  factory RecommendationEntity.fromJson(Map<String, dynamic> json) {
    return RecommendationEntity(
      title: json['title'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'details': details,
    };
  }
}

class RecommendationEntitys {
  List<RecommendationEntity> medicationsRecommended;
  List<RecommendationEntity> dietRecommended;
  List<RecommendationEntity> exerciseRecommended;
  List<RecommendationEntity> lifestyleChangesRecommended;
  List<RecommendationEntity> stressManagementTechniquesRecommended;
  List<RecommendationEntity> sleepHygieneTechniquesRecommended;
  List<RecommendationEntity> mentalHealthTechniquesRecommended;
  List<RecommendationEntity> relaxationTechniquesRecommended;
  List<RecommendationEntity> socialSupportTechniquesRecommended;
  List<RecommendationEntity> otherRecommendationEntitys;

  RecommendationEntitys({
    required this.medicationsRecommended,
    required this.dietRecommended,
    required this.exerciseRecommended,
    required this.lifestyleChangesRecommended,
    required this.stressManagementTechniquesRecommended,
    required this.sleepHygieneTechniquesRecommended,
    required this.mentalHealthTechniquesRecommended,
    required this.relaxationTechniquesRecommended,
    required this.socialSupportTechniquesRecommended,
    required this.otherRecommendationEntitys,
  });

  factory RecommendationEntitys.fromJson(Map<String, dynamic> json) {
    return RecommendationEntitys(
      medicationsRecommended: (json['medications_recommended'] as List)
          .map((i) => RecommendationEntity.fromJson(i))
          .toList(),
      dietRecommended: (json['diet_recommended'] as List)
          .map((i) => RecommendationEntity.fromJson(i))
          .toList(),
      exerciseRecommended: (json['exercise_recommended'] as List)
          .map((i) => RecommendationEntity.fromJson(i))
          .toList(),
      lifestyleChangesRecommended:
          (json['lifestyle_changes_recommended'] as List)
              .map((i) => RecommendationEntity.fromJson(i))
              .toList(),
      stressManagementTechniquesRecommended:
          (json['stress_management_techniques_recommended'] as List)
              .map((i) => RecommendationEntity.fromJson(i))
              .toList(),
      sleepHygieneTechniquesRecommended:
          (json['sleep_hygiene_techniques_recommended'] as List)
              .map((i) => RecommendationEntity.fromJson(i))
              .toList(),
      mentalHealthTechniquesRecommended:
          (json['mental_health_techniques_recommended'] as List)
              .map((i) => RecommendationEntity.fromJson(i))
              .toList(),
      relaxationTechniquesRecommended:
          (json['relaxation_techniques_recommended'] as List)
              .map((i) => RecommendationEntity.fromJson(i))
              .toList(),
      socialSupportTechniquesRecommended:
          (json['social_support_techniques_recommended'] as List)
              .map((i) => RecommendationEntity.fromJson(i))
              .toList(),
      otherRecommendationEntitys: (json['other_recommendations'] as List)
          .map((i) => RecommendationEntity.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medications_recommended':
          medicationsRecommended.map((i) => i.toJson()).toList(),
      'diet_recommended': dietRecommended.map((i) => i.toJson()).toList(),
      'exercise_recommended':
          exerciseRecommended.map((i) => i.toJson()).toList(),
      'lifestyle_changes_recommended':
          lifestyleChangesRecommended.map((i) => i.toJson()).toList(),
      'stress_management_techniques_recommended':
          stressManagementTechniquesRecommended.map((i) => i.toJson()).toList(),
      'sleep_hygiene_techniques_recommended':
          sleepHygieneTechniquesRecommended.map((i) => i.toJson()).toList(),
      'mental_health_techniques_recommended':
          mentalHealthTechniquesRecommended.map((i) => i.toJson()).toList(),
      'relaxation_techniques_recommended':
          relaxationTechniquesRecommended.map((i) => i.toJson()).toList(),
      'social_support_techniques_recommended':
          socialSupportTechniquesRecommended.map((i) => i.toJson()).toList(),
      'other_recommendations':
          otherRecommendationEntitys.map((i) => i.toJson()).toList(),
    };
  }
}
