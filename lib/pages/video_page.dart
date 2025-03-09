import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:app_006/pages/quiz_page.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    const String videoUrl = "https://youtu.be/z7k3vTx1ghk?si=j9ljC7_zLNwW3TBw";
    final videoId = YoutubePlayer.convertUrlToId(videoUrl)!;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "! شاهد الفيديو وابدأ التحدي ",
          style: GoogleFonts.tajawal(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Color.fromARGB(255, 141, 37, 160)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
          Positioned(
            bottom: 80,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: const Color.fromARGB(255, 141, 37, 160),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
              ),
              child: Text(
                "ابدأ الآن",
                style: GoogleFonts.tajawal(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
