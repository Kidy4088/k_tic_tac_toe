import 'package:flutter/material.dart';
import 'package:rive_loading/rive_loading.dart';

/// @author Kidy4088
/// @date 2021-06-18 20:08
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
  @override
  void initState() {
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
      body: RiveLoading(
        name: widget.name,
        loopAnimation: widget.animation,
        onSuccess: (data) {},
        onError: (error, stacktrace) {},
      ),
    );
  }
}
