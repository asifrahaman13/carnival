import 'package:shared_preferences/shared_preferences.dart';

// Function to save the user token
Future<void> saveUserToken(String? token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_token', token!);
}

// Function to retrieve the user token
Future<String?> getUserToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_token');
}

// Function to remove the user token
Future<void> removeUserToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_token');
}
