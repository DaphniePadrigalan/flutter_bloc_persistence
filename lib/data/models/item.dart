import 'dart:convert';

class Item {
  final String id;
  final String title;
  final bool isDone;

  Item({required this.id, required this.title, this.isDone = false});

  Item copyWith({String? title, bool? isDone}) {
    return Item(
      id: id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'isDone': isDone,
      };

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as String,
      title: map['title'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  static String encode(List<Item> items) =>
      json.encode(items.map((i) => i.toMap()).toList());

  static List<Item> decode(String items) =>
      (json.decode(items) as List).map((i) => Item.fromMap(i)).toList();
}
