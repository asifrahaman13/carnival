import 'package:carnival/internal/use_cases/auth_service.dart';
import 'package:carnival/presentation/drawer/AppDrawer.dart';
import 'package:carnival/presentation/screens/HomeScreen.dart';
import 'package:carnival/presentation/screens/SettingsScreen.dart';
import 'package:carnival/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'injection_container.dart' as di;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(const MyApp());
}

final AuthService _authService = GetIt.instance<AuthService>();


// Firebase sign-in function
Future<UserCredential?> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  var user = await FirebaseAuth.instance.signInWithCredential(credential);

  if (googleAuth?.idToken != null) {

    print("#################### Google Auth Token: ${googleAuth!.idToken}");
    print("############################################ User: $user");
    final  result = await _authService.authenticate(googleAuth.idToken!);
    result.fold(
      (failure) => print("Authentication Failed"),
      (authEntity) async {
        final token = authEntity.token;
        print(
            "#################### Authentication Success: ${token}");

        await saveUserToken(token);
      },
    );
  }
  return user;
}

// Check if the user token exists
Future<bool> userTokenExists() async {
  String? token = await getUserToken();
  return token != null && token.isNotEmpty;
}

// Your existing MyApp class
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
      home: const MyHomePage(title: 'Carnival'),
    );
  }
}

// Your existing MyHomePage class
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Your existing _MyHomePageState class
class _MyHomePageState extends State<MyHomePage> {
  int _selectedDrawerIndex = 0;
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  void _checkSignInStatus() async {
    bool signedIn = await userTokenExists();
    setState(() {
      _isSignedIn = signedIn;
    });
  }

  void _onDrawerItemTap(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const SettingsScreen(),
  ];

  // Trigger Google sign-in
  Future<void> _handleSignIn() async {
    try {
      var user = await signInWithGoogle();
      if (user != null) {
        setState(() {
          _isSignedIn = true; // Update the state to show the home screen
        });
      }
    } catch (e) {
      // Handle sign-in errors here
      print('Error signing in with Google: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in with Google. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isSignedIn) {
      return LoginScreen(onSignIn: _handleSignIn);
    }

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

class LoginScreen extends StatelessWidget {
  final Future<void> Function() onSignIn;

  const LoginScreen({super.key, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onSignIn,
        child: const Text('Sign in with Google'),
      ),
    );
  }
}
