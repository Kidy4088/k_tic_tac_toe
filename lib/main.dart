import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:k_tic_tac_toe/game_ui/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'K Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
      ),
      home: HomeScreen(),
    );
  }
}
