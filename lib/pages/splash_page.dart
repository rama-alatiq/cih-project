import 'package:app_006/pages/video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

@override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2),
    (){
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context)=> const VideoPage()),
        );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: const Color(0xFF433667),
      body: Center(
          child: AnimationConfiguration.synchronized(
        child: FadeInAnimation(
          duration: const Duration(seconds: 3),
          child: Image.asset('assets/images/logo.png'),
        ),
      )),
    );
  }
}