import 'package:flutter/material.dart';

import 'BottomNavSreenSub/Canceled_screen.dart';
import 'BottomNavSreenSub/Completed_screen.dart';
import 'BottomNavSreenSub/Progress_screen.dart';
import 'BottomNavSreenSub/newTask_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectIndex = 0;
  final List<Widget> _navScreens = const [
    NewTask(),
    Progress(),
    Completed(),
    Canceled(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Here show the list of screen by order/ selectedIndex carry the order index
      body: _navScreens[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        ///here Stored current tab Item,Usecase1:bottom navBar e Item click e selectiveItemColor active hoy, i mean change hoy
          ///currentIndex e current tap dessi jeno Nvbar ecolor cng hoy
          currentIndex: _selectIndex,
          onTap: (index) {
            _selectIndex = index; /// here tracking/collecting the tab
            setState(() {});
          },
          selectedItemColor: Colors.green,
          showSelectedLabels: true,
          unselectedItemColor:Colors.grey,
          showUnselectedLabels: true,


          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.add_task), label: 'New Task'),
            BottomNavigationBarItem(
                icon: Icon(Icons.change_circle_outlined), label: 'Progress'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check), label: 'Completed'),
            BottomNavigationBarItem(
                icon: Icon(Icons.cancel_outlined), label: 'Canceled'),
          ]),
    );
  }
}
