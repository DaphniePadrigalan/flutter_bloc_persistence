import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/item.dart';
import '../../data/repositories/item_repository.dart';

class ItemCubit extends Cubit<List<Item>> {
  final ItemRepository repository;
  final Uuid _uuid = const Uuid();

  ItemCubit(this.repository) : super([]) {
    load();
  }

  Future<void> load() async {
    final items = await repository.loadItems();
    emit(items);
  }

  Future<void> addItem(String title) async {
    final newItem = Item(id: _uuid.v4(), title: title);
    final updated = [...state, newItem];
    await repository.saveItems(updated);
    emit(updated);
  }

  Future<void> toggleStatus(String id) async {
    final updated = state.map((item) {
      if (item.id == id) {
        return item.copyWith(isDone: !item.isDone);
      }
      return item;
    }).toList();
    await repository.saveItems(updated);
    emit(updated);
  }

  Future<void> deleteItem(String id) async {
    final updated = state.where((item) => item.id != id).toList();
    await repository.saveItems(updated);
    emit(updated);
  }
}
