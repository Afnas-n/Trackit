// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/controller/bottombar_controller.dart';
import 'package:trackit/view/additem_page.dart';
import 'home_page.dart';

class Bottombar extends StatelessWidget {
  const Bottombar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomcontroller = Provider.of<BottombarCntrl>(context);

    return Scaffold(
      body: IndexedStack(
        index: bottomcontroller.currentIndex,
        children: <Widget>[
          const HomePage(),
          AdditemPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF00192D),
        currentIndex: bottomcontroller.currentIndex,
        onTap: (index) => bottomcontroller.setIndex(index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet, color: Color(0xFFFFFFFF)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Color(0xFFFFFFFF)),
            label: '',
          ),
        ],
      ),
    );
  }
}
