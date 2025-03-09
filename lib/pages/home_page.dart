import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

int currentPage=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 217, 163, 227),
          title: const Text(
            "Quiz App",
            style: TextStyle(
              color: Color.fromARGB(255, 43, 43, 43),
              fontSize: 27,
            ),
          ),
          elevation: 10,
          shadowColor: const Color.fromARGB(155, 0, 0, 0)),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPage=index;
            });
          },
          selectedIndex: currentPage,
          indicatorColor: const Color.fromARGB(255, 194, 124, 207),
          backgroundColor: const Color.fromARGB(255, 240, 222, 243),
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 57, 56, 56),
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.quiz,
                color: Color.fromARGB(255, 57, 56, 56),
              ),
              label: "Quiz",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 57, 56, 56),
              ),
              label: "Profile",
            ),
          ]),
    );
  }
}
