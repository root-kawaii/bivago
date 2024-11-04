import 'package:flutter/material.dart';
import 'package:bivago/pages/home.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../utils/sanification.dart';
import '../utils/queryNotes.dart';
import 'package:bivago/pages/onBoardin.dart';

void main() {
  runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Register Page',
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (errorMessage == "")
                ? const SizedBox()
                : Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _register();
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    Savior savior = Savior();

    // Perform registration logic here (e.g., save to database, API call)

    // For demonstration, print the registration details
    print('Registration Details:');
    print('Username: $username');
    print('Email: $email');
    print('Password: $password');

    print(username.isValidName);
    print(password.isValidPassword);

    if (username.isValidName &&
        email.isValidEmail &&
        password.isValidPassword) {
      var firstObject = ParseObject('Users')
        ..set(
          'email',
          email,
        )
        ..set('username', username)
        ..set('password', password);
      // ..set('check', "dunno");
      var response = await firstObject.save();
      print(response.success);
      if (response.success) {
        // Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OnBoarding(
                    key: const Key("1"),
                    title: '',
                  )),
        );
      } else {
        setState(() {
          errorMessage = "communication error";
        });
      }
    } else {
      setState(() {
        errorMessage = "wrong info";
      });
    }
    savior.initUser();
  }
}
