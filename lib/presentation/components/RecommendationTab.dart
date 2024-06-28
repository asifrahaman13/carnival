// ignore: file_names
import 'package:carnival/internal/entities/recommendation_entity.dart';
import 'package:carnival/internal/use_cases/recommendation_service.dart';
import 'package:carnival/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Recommendationstab extends StatefulWidget {
  const Recommendationstab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecommendationtabState createState() => _RecommendationtabState();
}

class _RecommendationtabState extends State<Recommendationstab> {
  final RecommendationService _recommendationService =
      GetIt.instance<RecommendationService>();

  List<RecommendationEntity> _recommendations = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    getRecommendations();
  }

  Future<void> getRecommendations() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final token = await getUserToken();
    print("######################################## $token");

    final result = await _recommendationService.getRecommendations(token!);
    print("######################################### $result");

    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _errorMessage = "Failed to get recommendations";
        });
        print("################################ Failed to get recommendations");
      },
      (recommendations) async {
        setState(() {
          _isLoading = false;
          _recommendations = [
            ...recommendations.medicationsRecommended,
            ...recommendations.dietRecommended,
            ...recommendations.exerciseRecommended,
            ...recommendations.lifestyleChangesRecommended,
            ...recommendations.stressManagementTechniquesRecommended,
            ...recommendations.sleepHygieneTechniquesRecommended,
            ...recommendations.mentalHealthTechniquesRecommended,
            ...recommendations.relaxationTechniquesRecommended,
            ...recommendations.socialSupportTechniquesRecommended,
            ...recommendations.otherRecommendationEntitys,
          ];
        });
        print(
            "###################################### Recommendations: $_recommendations");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _recommendations.isEmpty
                  ? const Center(
                      child: Text("Data not available"),
                    )
                  : ListView.builder(
                      itemCount: _recommendations.length,
                      itemBuilder: (context, index) {
                        final recommendation = _recommendations[index];
                        return ListTile(
                          title: Text(recommendation.title),
                          subtitle: Text(recommendation.details),
                        );
                      },
                    ),
    );
  }
}
