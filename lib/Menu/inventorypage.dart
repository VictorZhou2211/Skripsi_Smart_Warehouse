import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/data.dart';
import 'package:flutter_application_1/Inventory/outstock.dart';
import 'package:flutter_application_1/main.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(const InventoryPage());
}

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color.fromARGB(255, 11, 41, 92)),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Inventory'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Data> datalist = [];

  bool sort = true;
  List<Data>? filterData;

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterData!.sort((a, b) => a.name!.compareTo(b.name!));
      } else {
        filterData!.sort((a, b) => b.name!.compareTo(a.name!));
      }
    }
  }

  @override
  void initState() {
    filterData = myData;
    super.initState();
    DatabaseReference referenceData =
        FirebaseDatabase.instance.ref().child("attendence");
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: new Text(
                  "Victor",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                accountEmail: new Text("victorciusteven@gmail.com"),
                currentAccountPicture:
                    CircleAvatar(backgroundImage: NetworkImage("")),
                decoration:
                    new BoxDecoration(color: Color.fromARGB(255, 11, 41, 92)),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return MyApp();
                  }));
                },
              ),
              ListTile(
                leading: Icon(Icons.edit_document),
                title: Text("Report"),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Exit"),
              ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Theme(
                    data: ThemeData.light()
                        .copyWith(cardColor: Theme.of(context).canvasColor),
                    child: PaginatedDataTable(
                      sortColumnIndex: 0,
                      sortAscending: sort,
                      header: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              hintText: "Enter something to filter"),
                          onChanged: (value) {
                            setState(() {
                              myData = filterData!
                                  .where((element) =>
                                      element.name!.contains(value))
                                  .toList();
                            });
                          },
                        ),
                      ),
                      source: RowSource(
                        myData: myData,
                        count: myData.length,
                      ),
                      rowsPerPage: 8,
                      columnSpacing: 8,
                      columns: [
                        DataColumn(
                            label: const Text(
                              "Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            onSort: (columnIndex, ascending) {
                              setState(() {
                                sort = !sort;
                              });

                              onsortColum(columnIndex, ascending);
                            }),
                        const DataColumn(
                          label: Text(
                            "Tag Number",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ),
                        const DataColumn(
                          label: Text(
                            "Time",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}

class RowSource extends DataTableSource {
  var myData;
  final count;
  RowSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      // return recentFileDataRow(myData![index]);
    } else
      return null;
    return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow recentFileDataRow({required Map Attedence}) {
  return DataRow(
    cells: [
      DataCell(Text(Attedence['id'])),
      DataCell(Text(Attedence['uid'])),
      DataCell(Text(Attedence['time'])),
    ],
  );
}
