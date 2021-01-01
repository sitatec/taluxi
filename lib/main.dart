import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_manager/user_manager.dart';

import 'app.dart';

// TODO check test code coverage
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await initializeUserMangerServices();
  runApp(
    App(),
  );
}

// TODO: write copyright in all files.
