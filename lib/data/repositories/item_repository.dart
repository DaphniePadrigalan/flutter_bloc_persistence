import 'package:shared_preferences/shared_preferences.dart';
import '../models/item.dart';

class ItemRepository {
  static const String storageKey = 'items_data';

  Future<List<Item>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(storageKey);
    if (jsonString == null) return [];
    try {
      return Item.decode(jsonString);
    } catch (_) {
      return [];
    }
  }

  Future<void> saveItems(List<Item> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, Item.encode(items));
  }
}
