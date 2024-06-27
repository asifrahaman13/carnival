import 'package:carnival/presentation/drawer/AppDrawer.dart';
import 'package:carnival/presentation/screens/HomeScreen.dart';
import 'package:carnival/presentation/screens/SettingsScreen.dart';
import 'package:flutter/material.dart';
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

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const SettingsScreen()
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
      body: _widgetOptions.elementAt(_selectedDrawerIndex),
    );
  }
}
