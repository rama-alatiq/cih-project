import 'package:flutter/material.dart';
import 'package:app_006/pages/quiz_page.dart';
import 'package:confetti/confetti.dart';
import 'package:google_fonts/google_fonts.dart';

class ScorePage extends StatefulWidget {
  final int score;
  final int totalQuestions;

  const ScorePage(
      {super.key, required this.score, required this.totalQuestions});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/scoreBackground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 29,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "النتيجة النهائية",
                style: GoogleFonts.tajawal(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
                padding: const EdgeInsets.all(20),
                child: Text(
                  "${widget.score} / ${widget.totalQuestions}",
                  style: const TextStyle(
                    fontSize: 43,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => QuizPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "إعادة الاختبار",
                  style: GoogleFonts.tajawal(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(154, 0, 0, 0),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
