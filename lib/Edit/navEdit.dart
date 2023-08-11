import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Edit/EditInv.dart';
import 'package:flutter_application_1/Edit/EditInvOut.dart';
import 'package:flutter_application_1/Inventory/outstock.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/fetch.dart';
import 'package:flutter_application_1/Inventory/inventorystock.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavEdit extends StatefulWidget {
  const NavEdit({super.key});

  @override
  State<NavEdit> createState() => _NavEditState();
}

class _NavEditState extends State<NavEdit> {
  int _selectedIndex = 0;
  final List<String> _titles = const [
    'Stock In',
    'Stock Out',
  ];
  final List<Widget> _tabs = const [
    EditInvin(),
    EditInvout(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //title: Text(_titles[_selectedIndex]),
      //),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: Container(
        //color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
          child: GNav(
              backgroundColor: Colors.white,
              color: Colors.grey,
              activeColor: Colors.deepOrange.shade900,
              tabBackgroundColor: Colors.grey,
              gap: 1,
              onTabChange: (newIndex) =>
                  setState(() => _selectedIndex = newIndex),
              tabs: const [
                GButton(
                  icon: Icons.input,
                  text: 'Edit Stock In',
                ),
                GButton(
                  icon: Icons.output,
                  text: 'Edit Stock Out',
                ),
              ]),
        ),
      ),
    );
  }
}
