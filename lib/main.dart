
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: TextTheme(
            bodyMedium: GoogleFonts.cormorantGaramond(),
            bodyLarge: GoogleFonts.cormorantGaramond(),
          ),
        ),
      home: const AuthStateScreen(),
    );
  }
}
