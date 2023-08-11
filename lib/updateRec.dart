import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({Key? key, required this.warehouseKey}) : super(key: key);

  final String warehouseKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  final userNameController = TextEditingController();
  final userAgeController = TextEditingController();
  final userSalaryController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('warehouse');
    getStudentData();
  }

  void getStudentData() async {
    DataSnapshot snapshot = await dbRef.child(widget.warehouseKey).get();

    Map warehouse = snapshot.value as Map;

    userNameController.text = warehouse['uid'];
    userAgeController.text = warehouse['id'];
    userSalaryController.text = warehouse['time'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating record'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Updating Stock In Data',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                enabled: false,
                controller: userNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Id',
                  hintText: 'Enter Your Name',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userAgeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Your Age',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userSalaryController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Time',
                  hintText: 'Enter Your Salary',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  Map<String, String> warehouse = {
                    'uid': userNameController.text,
                    'id': userAgeController.text,
                    'time': userSalaryController.text
                  };

                  dbRef
                      .child(widget.warehouseKey)
                      .update(warehouse)
                      .then((value) => {Navigator.pop(context)});
                  Fluttertoast.showToast(msg: "Update Successful");
                },
                child: const Text('Update Data'),
                color: Colors.orange.shade300,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
