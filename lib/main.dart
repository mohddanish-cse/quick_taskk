import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quick_taskk/screens/registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 's1oEMFbmLRsAQISpNxuAdbTYN4tKusoepcdVxBje';
  const keyClientKey = 'R7s8DbfzfM0u2wtKTIACiB2j1aHyI5w7KTfjqs1C';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter SignUp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegistrationPage(),
    );
  }
}
