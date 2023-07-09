//tableName
const String table = "employee";

class MainModel {
  final int? id;
  final String? name;
  final String? occupation;
  final int? age;

  MainModel({
    this.id,
    this.age,
    this.name,
    this.occupation,
  });

  factory MainModel.fromJson(Map<String, dynamic> data) {
    return MainModel(
      id: data[FiledDatabase.id],
      name: data[FiledDatabase.name],
      occupation: data[FiledDatabase.occupation],
      age: data[FiledDatabase.age],
    );
  }

  Map<String, Object?> toJson() {
    return {
      FiledDatabase.id: id,
      FiledDatabase.age: age,
      FiledDatabase.name: name,
      FiledDatabase.occupation: occupation,
    };
  }

  MainModel copy({int? id, String? name, String? occupation, int? age}) {
    return MainModel(
      id: id ?? this.id,
      name: name ?? this.name,
      occupation: occupation ?? this.occupation,
      age: age ?? this.age,
    );
  }
}

class FiledDatabase {
  static const String id = "_id";
  static const String name = "_name";
  static const String occupation = "_occupation";
  static const String age = "_age";

  static List<String> allValues = <String>[
    id,
    name,
    occupation,
    age,
  ];
}
