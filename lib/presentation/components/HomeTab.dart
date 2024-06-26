import 'package:carnival/internal/use_cases/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final AuthService _authService = GetIt.instance<AuthService>();

  Future<void> _authenticate() async {
    final result = await _authService.authenticate("username", "password");
    result.fold(
      (failure) => print("Authentication Failed"),
      (authEntity) => print("#################### Authentication Success: ${authEntity.token}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _authenticate,
        child: const Text("Authenticate"),
      ),
    );
  }
}
