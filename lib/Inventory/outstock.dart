import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/data.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/Menu/menu.dart';
import 'package:flutter_application_1/Data/user.dart';

class OutPG extends StatefulWidget {
  const OutPG({Key? key}) : super(key: key);

  @override
  State<OutPG> createState() => _OutPG();
}

class _OutPG extends State<OutPG> {
  Query dbRef = FirebaseDatabase.instance.ref().child('warehouse');
  final searchFilter = TextEditingController();

  Widget listItem({required Map Warehouse}) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.orange.shade300,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                  flex: 2,
                  child: Text(
                    "Id",
                    style: TextStyle(fontSize: 18),
                  )),
              Expanded(
                  flex: 5,
                  child: Text(
                    Warehouse['uid'],
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
          Row(
            children: [
              const Expanded(
                  flex: 2,
                  child: Text(
                    "Name",
                    style: TextStyle(fontSize: 18),
                  )),
              Expanded(
                  flex: 5,
                  child: Text(
                    Warehouse['id'],
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
          Row(
            children: [
              const Expanded(
                  flex: 2,
                  child: Text(
                    "Time",
                    style: TextStyle(fontSize: 18),
                  )),
              Expanded(
                  flex: 5,
                  child: Text(
                    Warehouse['time'],
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 0,
                  child: Text(
                    "Status           ",
                    style: TextStyle(fontSize: 18),
                  )),
              Icon(
                Icons.cancel_rounded,
                color: Colors.red,
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            style: TextStyle(color: Colors.white),
            controller: searchFilter,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
              ),
              focusedBorder: new OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange, width: 4.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
              ),
            ),
            onChanged: (String value) {
              setState(() {});
            },
          ),
          backgroundColor: Colors.deepOrange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return MenuScreen();
              }));
            },
          ),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef.orderByChild("status").equalTo(1),
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              final Warehouse = snapshot.child('id').value.toString();
              if (searchFilter.text.isEmpty) {
                Map Warehouse = snapshot.value as Map;
                Warehouse['key'] = snapshot.key;
                return listItem(Warehouse: Warehouse);
              } else if (Warehouse.toLowerCase()
                  .contains(searchFilter.text.toLowerCase().toLowerCase())) {
                Map Warehouse = snapshot.value as Map;
                Warehouse['key'] = snapshot.key;
                return listItem(Warehouse: Warehouse);
              } else {
                return Container();
              }
            },
          ),
        ));
  }

  void SearchMethod(String text) {
    DatabaseReference searchRef =
        FirebaseDatabase.instance.ref().child('warehouse');
  }
}
