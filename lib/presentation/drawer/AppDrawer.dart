


import 'package:flutter/material.dart';

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


