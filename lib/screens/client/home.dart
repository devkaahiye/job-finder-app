import 'package:flutter/material.dart';
import 'package:job_findder_app/constants/appColors.dart';
import 'package:job_findder_app/screens/client/account/screens/user.dart';
import 'package:job_findder_app/screens/client/bookmark/screens/book.dart';
import 'package:job_findder_app/screens/client/home_screen.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  List<Widget> pagesList = [
    const HomeScreen(),
    const BookMark(),
    const UserScreen()
  ];

  void updatePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: pagesList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromRGBO(0, 110, 245, 1),
          currentIndex: currentIndex,
          onTap: updatePage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmarks_outlined), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: ''),
          ]),
    );
  }
}
