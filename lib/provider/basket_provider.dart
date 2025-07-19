import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruitapp/model/basket_item.dart';

class BasketNotifier extends StateNotifier<List<BasketItem>> {
  BasketNotifier() : super([]);

  void addItem(BasketItem newItem) {
    final index = state.indexWhere((item) => item.id == newItem.id);

    if (index >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            state[i].copyWith(quantity: state[i].quantity + newItem.quantity)
          else
            state[i],
      ];
    } else {
      state = [...state, newItem];
    }
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void clearBasket() {
    state = [];
  }
}

final basketProvider = StateNotifierProvider<BasketNotifier, List<BasketItem>>((
  ref,
) {
  return BasketNotifier();
});
