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
  String _userDetails = '';
  final AuthService _authService = GetIt.instance<AuthService>();

  @override
  void initState() {
    super.initState();
    _loadUserToken();
  }

  Future<void> _loadUserToken() async {
    final token = await getUserToken();
    print(
        "###########################################################################");
    print(token);
    final result = await _authService.validateUser(token!);
    print(result);
    result.fold(
      (failure) {
        setState(() {
          _userDetails = 'Authentication Failed very sorry';
        });
      },
      (userEntity) async {
        final username = userEntity.name;
        setState(() {
          _userDetails = 'Authentication Success: $username';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_userDetails),
    );
  }
}
