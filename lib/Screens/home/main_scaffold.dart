import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:dog_did/screens/dogs/dogs_page.dart';
import 'package:dog_did/screens/home/home_page.dart';
import 'package:dog_did/screens/schedule/schedule_page.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int currentIndex = 0;

  final screens = [
    const HomePage(title: 'Home page'),
    const DogsPage(),
    const SchedulePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => setState(() => currentIndex = value),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: colorScheme().primary.withOpacity(.5),
        unselectedFontSize: 15,
        unselectedIconTheme: const IconThemeData(size: 20),
        enableFeedback: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets_rounded),
            label: 'Dogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Schedule',
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
