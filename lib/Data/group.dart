/* import 'package:firebase_database/firebase_database.dart';

class Item {
  String name;
  String description;

  Item({required this.name, required this.description});
}

final DatabaseReference _itemsRef =
    FirebaseDatabase.instance.reference().child('items');

Stream<List<Item>> getItems() {
  return _itemsRef.onValue.map((event) {
    List<Item> items = [];
    Object? data = event.snapshot.value;
    Map<String, dynamic> datas = event.snapshot.value as Map<String, dynamic>;
    data.forEach((key, value) {
      items.add(Item(name: value['name'], description: value['description']));
    });

    // Group items by name
    Map<String, List<Item>> groupedItems = {};
    items.forEach((item) {
      if (!groupedItems.containsKey(item.name)) {
        groupedItems[item.name] = [];
      }
      groupedItems[item.name]!.add(item);
    });

    // Return a list of groups
    return groupedItems.values.toList();
  });
}
 */