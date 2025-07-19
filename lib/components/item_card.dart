import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitapp/components/custom_icon_button.dart';
import 'package:fruitapp/constants.dart';
import 'package:fruitapp/model/basket_item.dart';
import 'package:fruitapp/model/favorite_item.dart';
import 'package:fruitapp/provider/basket_provider.dart';
import 'package:fruitapp/provider/favorites_provider.dart';
import 'package:fruitapp/screens/item_details.dart';
import 'package:intl/intl.dart';

class ItemCard extends ConsumerWidget {
  const ItemCard({
    super.key,
    required this.itemId,
    required this.itemName,
    required this.itemImageUrl,
    required this.itemPrice,
    this.color = Colors.white,
  });

  final String itemId;
  final String itemName;
  final String itemImageUrl;
  final int itemPrice;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = NumberFormat('#,###');
    final formattedPrice = formatter.format(itemPrice);

    final basket = ref.watch(basketProvider);
    final isFavorite = ref
        .watch(favoritesProvider)
        .any((item) => item.id == itemId);

    final basketItem = basket.firstWhere(
      (item) => item.id == itemId,
      orElse: () => BasketItem(
        id: itemId,
        title: itemName,
        imageUrl: itemImageUrl,
        price: itemPrice,
        quantity: 0,
        color: color,
      ),
    );

    final isInCart = basketItem.quantity > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetails(
                itemId: itemId,
                itemTitle: itemName,
                itemImage: itemImageUrl,
                itemPrice: itemPrice,
                itemColor: color,
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: color,
          child: SizedBox(
            height: 210,
            width: 160,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8),
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(favoritesProvider.notifier)
                            .toggleFavorite(
                              FavoriteItem(
                                id: itemId,
                                title: itemName,
                                imageUrl: itemImageUrl,
                                price: itemPrice,
                                color: color,
                              ),
                            );
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(
                                isFavorite
                                    ? 'Removed from Favorites'
                                    : 'Added to Favorites',
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                      },
                      child: Icon(
                        isFavorite
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: itemName,
                  child: Image.asset(
                    itemImageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    itemName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '₦ ',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontSize: 21,
                                      color: kPrimaryColor,
                                    ),
                              ),
                              TextSpan(
                                text: formattedPrice,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      fontSize: 18,
                                      color: kPrimaryColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (isInCart)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '${basketItem.quantity}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: kPrimaryColor,
                                ),
                          ),
                        )
                      else
                        CustomIconButton(
                          onPressed: () {
                            ref
                                .read(basketProvider.notifier)
                                .addItem(
                                  BasketItem(
                                    id: itemId,
                                    title: itemName,
                                    imageUrl: itemImageUrl,
                                    price: itemPrice,
                                    quantity: 1,
                                    color: color,
                                  ),
                                );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
