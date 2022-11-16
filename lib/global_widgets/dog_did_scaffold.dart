import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:dog_did/screens/dogs/dogs_page.dart';
import 'package:dog_did/screens/home/home_page.dart';
import 'package:flutter/material.dart';

class DogDidScaffold extends StatelessWidget {
  DogDidScaffold({super.key, required this.appBar, required this.body});
  final dynamic body;
  final dynamic appBar;
  final screens = [const HomePage(title: 'Home page'), const DogsPage()];
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme().primaryContainer,
              Colors.black,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: body,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            unselectedItemColor: colorScheme().primary.withOpacity(.5),
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
        ));
  }
}
