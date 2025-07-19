import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruitapp/components/item_card.dart';
import 'package:fruitapp/provider/favorites_provider.dart';

class Favorites extends ConsumerWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.orange,
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorite items yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favorites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 240,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final item = favorites[index];
                return ItemCard(
                  itemId: item.id,
                  itemName: item.title,
                  itemImageUrl: item.imageUrl,
                  itemPrice: item.price,
                  color: item.color,
                );
              },
            ),
    );
  }
}
