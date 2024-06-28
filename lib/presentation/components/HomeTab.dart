// ignore: file_names
import 'package:carnival/internal/use_cases/auth_service.dart';
import 'package:carnival/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String _userToken = '';
  final AuthService _authService = GetIt.instance<AuthService>();

  @override
  void initState() {
    super.initState();
    _loadUserToken();
  }

  Future<void> _authenticate() async {
    final result = await _authService.authenticate("username");
    result.fold(
      (failure) => print("Authentication Failed"),
      (authEntity) => print(
          "#################### Authentication Success: ${authEntity.token}"),
    );
  }

  Future<void> _loadUserToken() async {
    final token = await getUserToken();
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^66 $token');
    setState(() {
      _userToken = token ?? 'No token found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _authenticate,
        child: Text(_userToken),
      ),
    );
  }
}
