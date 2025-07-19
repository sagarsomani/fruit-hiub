import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruitapp/model/favorite_item.dart';

class FavoritesNotifier extends StateNotifier<List<FavoriteItem>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(FavoriteItem item) {
    final exists = state.any((fav) => fav.id == item.id);
    if (exists) {
      state = state.where((fav) => fav.id != item.id).toList();
    } else {
      state = [...state, item];
    }
  }

  bool isFavorite(String id) {
    return state.any((item) => item.id == id);
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<FavoriteItem>>(
      (ref) => FavoritesNotifier(),
    );
