class Data {
  String? name;
  int? tagnumber;
  String? time;

  Data({this.name, this.tagnumber, this.time});

  factory Data.fromMap(Map) {
    return Data(
      name: Map['name'],
      tagnumber: Map['tagnumber'],
      time: Map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'tagnumber': tagnumber,
      'time': time,
    };
    //Data({required Map Attedence});
  }
}

List<Data> myData = [];
