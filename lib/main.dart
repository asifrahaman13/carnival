import 'package:carnival/internal/use_cases/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'injection_container.dart' as di;

void main() {
   di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDrawerIndex = 0;

  void _onDrawerItemTap(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
  }

  static  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: AppDrawer(
        onDrawerItemTap: _onDrawerItemTap,
        selectedDrawerIndex: _selectedDrawerIndex,
      ),
      body: Column(
        children: [
          _widgetOptions.elementAt(_selectedDrawerIndex),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go back!'),
          ),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.onDrawerItemTap,
    required this.selectedDrawerIndex,
  });

  final Function(int) onDrawerItemTap;
  final int selectedDrawerIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Home'),
            selected: selectedDrawerIndex == 0,
            onTap: () {
              onDrawerItemTap(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Settings'),
            selected: selectedDrawerIndex == 1,
            onTap: () {
              onDrawerItemTap(1);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}


class HomeScreen extends StatelessWidget{
   HomeScreen({super.key});

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
    return  Center(
        child: ElevatedButton(
          onPressed: _authenticate,
          child: Text("Authenticate"),
        ),
      );
  }
}

class SettingsScreen extends StatelessWidget{
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Settings Page'),
    );
  }
}