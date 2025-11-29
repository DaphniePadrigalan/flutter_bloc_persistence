import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/item_cubit.dart';
import '../../data/models/item.dart';
import '../widgets/item_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Items')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Add Item',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) => _add(context),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _add(context),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ItemCubit, List<Item>>(
              builder: (context, items) {
                if (items.isEmpty) {
                  return const Center(child: Text('No items yet'));
                }
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => ItemTile(item: items[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _add(BuildContext context) {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    context.read<ItemCubit>().addItem(text);
    controller.clear();
  }
}
