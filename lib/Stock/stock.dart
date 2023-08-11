/* import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_firebase_series/screens/update_record.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Item>>(
      stream: getItems(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<List<Item>> groups = snapshot.data!;
          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              List<Item> group = groups[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(group[0].name), // Display the group name
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: group.length,
                    itemBuilder: (context, index) {
                      Item item = group[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.description),
                      );
                    },
                  ),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
 */