import 'package:flutter/material.dart';
import 'package:supa_chat/core/secret/app_secret.dart';
import 'package:supa_chat/features/auth/presentation/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/di/di.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Supabase.initialize(
    url: AppSecret.url,
    anonKey: AppSecret.anonKek,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

