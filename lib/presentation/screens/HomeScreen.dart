import 'package:carnival/internal/use_cases/auth_service.dart';
import 'package:carnival/presentation/components/AssessmentTab.dart';
import 'package:carnival/presentation/components/DataTab.dart';
import 'package:carnival/presentation/components/HomeTab.dart';
import 'package:carnival/presentation/components/RecommendationTab.dart';
import 'package:carnival/presentation/components/WearableTab.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = GetIt.instance<AuthService>();
  int _selectedIndex = 0;

  Future<void> _authenticate() async {
    final result = await _authService.authenticate("username", "password");
    result.fold(
      (failure) => print("Authentication Failed"),
      (authEntity) => print("#################### Authentication Success: ${authEntity.token}"),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions=<Widget>[
    const HomeTab(),
    const DataTab(),
    const AssessmentTab(),
    const RecommendationsTab(),
    const WearableTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Assessment',
          ),
             BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Recommendations',
          ),
             BottomNavigationBarItem(
            icon: Icon(Icons.watch),
            label: 'Wearable',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      
    );
  }
}