import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:k_tic_tac_toe/game_ui/home_screen.dart';
import 'package:k_tic_tac_toe/r.dart';
import 'package:rive/rive.dart';

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
      home: SplashScreen(
        name: R.assetsRive196Loading,
        animation: 'Animation 1',
        next: HomeScreen(),
        ready: Future.delayed(Duration(milliseconds: 800)),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    required this.name,
    required this.animation,
    required this.next,
    required this.ready,
  }) : super(key: key);

  final String name;
  final String animation;
  final Widget next;
  final Future ready;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final RiveAnimationController _controller;

  @override
  void initState() {
    _controller = SimpleAnimation(widget.animation);
    _initCallback();
    super.initState();
  }

  void _initCallback() {
    widget.ready.then((value) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return widget.next;
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RiveAnimation.asset(
        widget.name,
        controllers: [_controller],
      ),
    );
  }
}
