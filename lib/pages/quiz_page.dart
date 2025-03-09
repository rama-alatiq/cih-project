// import 'package:app_006/pages/home_page.dart';
import 'package:app_006/pages/score_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../data/question_model.dart';
import '../data/questions.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIdx = 0;
  int selectedOptionIdx = -1;
  int score = 0;
  final List<Question> questions = AppQuestions.fetchQuestions();
  late PageController pageController;
  bool answered = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void questionAnswered(int selectedIndex) {
    if (answered) return;

    setState(() {
      selectedOptionIdx = selectedIndex;
      answered = true;
    });

    if (selectedIndex == questions[currentQuestionIdx].answerIndex) {
      score++;
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (currentQuestionIdx < questions.length - 1) {
        setState(() {
          currentQuestionIdx++;
          selectedOptionIdx = -1;
          answered = false;
        });
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ScorePage(score: score, totalQuestions: questions.length)),
        );
      }
    });
  }

  Color getButtonColor(int optionIndex) {
    if (selectedOptionIdx == -1) {
      return const Color.fromARGB(255, 196, 133, 207);
    } else if (optionIndex == questions[currentQuestionIdx].answerIndex) {
      return Colors.green;
    } else if (optionIndex == selectedOptionIdx) {
      return Colors.red;
    }
    return const Color.fromARGB(255, 196, 133, 207);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: LinearPercentIndicator(
                  animation: true,
                  width: 300,
                  lineHeight: 14,
                  percent: (currentQuestionIdx + 1) / questions.length,
                  barRadius: const Radius.circular(15),
                  backgroundColor: const Color.fromARGB(255, 236, 205, 241),
                  progressColor: const Color.fromARGB(255, 190, 96, 206),
                )),
            Expanded(
                child: PageView.builder(
                    itemCount: questions.length,
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                questions[index].question,
                                style: GoogleFonts.tajawal(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(168, 3, 0, 0),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 35),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 25),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: List.generate(
                                      questions[index].choices.length,
                                      (optionIndex) {
                                        return GestureDetector(
                                          onTap: () =>
                                              questionAnswered(optionIndex),
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  getButtonColor(optionIndex),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 4,
                                                    offset: Offset(2, 2))
                                              ],
                                            ),
                                            child: Text(
                                              questions[currentQuestionIdx]
                                                  .choices[optionIndex],
                                              style: GoogleFonts.tajawal(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                color: const Color.fromARGB(255, 255, 255, 255),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
