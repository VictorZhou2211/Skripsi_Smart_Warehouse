import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Edit/EditInv.dart';
import 'package:flutter_application_1/Edit/navEdit.dart';
import 'package:flutter_application_1/Inventory/navInv.dart';
import 'package:flutter_application_1/Menu/inventorypage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/Data/user.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Main Menu"),
        backgroundColor: Color.fromARGB(203, 153, 126, 1),
      ),
      backgroundColor: Color.fromARGB(255, 192, 192, 192),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "${loggedInUser.firstName} ${loggedInUser.secondName}",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              accountEmail: new Text("${loggedInUser.email}"),
              currentAccountPicture:
                  CircleAvatar(backgroundImage: AssetImage("images/js.jpg")),
              decoration:
                  new BoxDecoration(color: Color.fromARGB(255, 11, 41, 92)),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Exit"),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white60,
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              color: Colors.deepOrange,
              shadowColor: Colors.white,
              margin: EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return NavInv();
                  }));
                },
                splashColor: Colors.grey,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.inventory,
                      size: 70.0,
                      color: Colors.white,
                    ),
                    Text(
                      "Inventory",
                      style: new TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
              ),
            ),
            Card(
              color: Colors.deepOrange,
              margin: EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const NavEdit();
                  }));
                },
                splashColor: Colors.grey,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.edit,
                      size: 70.0,
                      color: Colors.white,
                    ),
                    Text(
                      "Edit Stock",
                      style: new TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
              ),
            ),
            Card(
              color: Colors.deepOrange,
              margin: EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return MenuScreen();
                  }));
                },
                splashColor: Colors.grey,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.location_pin,
                      size: 70.0,
                      color: Colors.white,
                    ),
                    Text(
                      "Location",
                      style: new TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
              ),
            ),
            Card(
              color: Colors.deepOrange,
              margin: EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () {
                  SystemNavigator.pop();
                },
                splashColor: Colors.grey,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.exit_to_app,
                      size: 70.0,
                      color: Colors.white,
                    ),
                    Text(
                      "Exit",
                      style: new TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
              ),
            ),
            Card(
              color: Colors.deepOrange,
              margin: EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return InventoryPage();
                  }));
                },
                splashColor: Colors.grey,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.edit_document,
                      size: 70.0,
                      color: Colors.white,
                    ),
                    Text(
                      "Edit",
                      style: new TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
