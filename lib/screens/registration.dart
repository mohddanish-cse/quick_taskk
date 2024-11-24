import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quick_taskk/constants/colors.dart';
import 'package:quick_taskk/screens/home.dart';
import 'package:quick_taskk/screens/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('QuickTask SignUp'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 200,
                  child: Text(
                    'QuickTask',
                    style: TextStyle(
                        color: tdBlue,
                        fontSize: 48,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextField(
                  controller: controllerUsername,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: tdBlack)),
                      labelText: 'Username'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: tdBlack)),
                      labelText: 'E-mail'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controllerPassword,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: tdBlack)),
                      labelText: 'Password'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: tdBlue),
                  child:
                      const Text('Sign Up', style: TextStyle(color: tdBGColor)),
                  onPressed: () => doUserRegistration(),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(foregroundColor: tdBlue),
                  child: const Text('Existing User? Login',
                      style: TextStyle(color: tdBlue)),
                  onPressed: () {
                    Get.to(() => const LoginPage());
                  },
                ),
              ],
            ),
          ),
        ));
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void doUserRegistration() async {
    final username = controllerUsername.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();
    final user = ParseUser.createUser(username, password, email);
    var response = await user.signUp();
    if (response.success) {
      Get.to(() => const HomePage());
    } else {
      showError(response.error!.message);
    }
  }
}
