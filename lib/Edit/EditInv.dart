import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Menu/inventorypage.dart';
import 'package:flutter_application_1/Menu/menu.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/updateRec.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:flutter_firebase_series/screens/update_record.dart';

class EditInvin extends StatefulWidget {
  const EditInvin({Key? key}) : super(key: key);

  @override
  State<EditInvin> createState() => _EditInvin();
}

class _EditInvin extends State<EditInvin> {
  Query dbRef = FirebaseDatabase.instance.ref().child('warehouse');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('warehouse');
  final searchFilter = TextEditingController();

  Widget listItem({required Map Warehouse}) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 15,
      ),
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
              const Expanded(
                  flex: 0,
                  child: Text(
                    "Status           ",
                    style: TextStyle(fontSize: 18),
                  )),
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              UpdateRecord(warehouseKey: Warehouse['key'])));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              GestureDetector(
                onTap: () {
                  onWillPop(Warehouse: Warehouse);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
            query: dbRef.orderByChild("status").equalTo(0),
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

  Future<void> updateDialog(
      String name, String id, BuildContext context, var key) {
    var nameController = TextEditingController(text: name);
    var idController = TextEditingController(text: id);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update Value"),
            content: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: "Name"),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: idController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: "Id"),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () {}, child: Text("Update")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancle")),
            ],
          );
        });
  }

  void UpdateData(String name, String id, var key) {
    // Map<String, String>  x = {"name": name,}
  }

  Future<bool> onWillPop({required Map Warehouse}) async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to delete this data?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'No',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              reference.child(Warehouse['key']).remove();
              Navigator.of(context).pop(false);
              Fluttertoast.showToast(msg: "Delete Successful");
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }
}
