import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruitapp/components/custom_back_button.dart';
import 'package:fruitapp/components/custom_elevated_button.dart';
import 'package:fruitapp/components/custom_icon_button.dart';
import 'package:fruitapp/constants.dart';
import 'package:fruitapp/model/basket_item.dart';
import 'package:fruitapp/model/favorite_item.dart';
import 'package:fruitapp/provider/basket_provider.dart';
import 'package:fruitapp/provider/favorites_provider.dart';
import 'package:intl/intl.dart';

class ItemDetails extends ConsumerStatefulWidget {
  const ItemDetails({
    super.key,
    required this.itemId,
    required this.itemTitle,
    required this.itemImage,
    required this.itemPrice,
    this.itemColor = Colors.white,
  });
  final String itemId;
  final String itemTitle;
  final String itemImage;
  final int itemPrice;
  final Color itemColor;

  @override
  ConsumerState<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends ConsumerState<ItemDetails> {
  final formatter = NumberFormat('#,###');
  late int quantity;

  @override
  void initState() {
    super.initState();
    final basket = ref.read(basketProvider);
    final basketItem = basket.firstWhere(
      (item) => item.id == widget.itemId,
      orElse: () => BasketItem(
        id: widget.itemId,
        title: widget.itemTitle,
        imageUrl: widget.itemImage,
        price: widget.itemPrice,
        quantity: 0,
        color: widget.itemColor,
      ),
    );
    if (basketItem.id.isNotEmpty && basketItem.quantity > 0) {
      quantity = basketItem.quantity;
    } else {
      quantity = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref
        .watch(favoritesProvider)
        .any((item) => item.id == widget.itemId);

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10,
              ),
              child: CustomBackButton(),
            ),
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: widget.itemTitle,
                child: Image.asset(widget.itemImage, height: 200),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
                decoration: BoxDecoration(
                  color: widget.itemColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.itemTitle,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 30),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity = quantity > 0 ? quantity - 1 : 0;
                            });
                          },
                          icon: Icon(Icons.remove_circle_outline, size: 40),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          '$quantity',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontSize: 30),
                        ),
                        const SizedBox(width: 20),
                        CustomIconButton(
                          size: 30,
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                        Spacer(),
                        Text(
                          '₦ ${formatter.format(widget.itemPrice * quantity)}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontSize: 30),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                      height: 60,
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'One Pack Contains:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.orange,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Red Quinoa, Lime, Honey, Blueberries, Strawberries, Mango, Fresh mint.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                      height: 50,
                    ),
                    Text(
                      'If you are looking for a new fruit salad to eat today, quinoa is the perfect brunch for you. make',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 14),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        CustomIconButton(
                          onPressed: () {
                            ref
                                .read(favoritesProvider.notifier)
                                .toggleFavorite(
                                  FavoriteItem(
                                    id: widget.itemId,
                                    title: widget.itemTitle,
                                    imageUrl: widget.itemImage,
                                    color: widget.itemColor,
                                    price: widget.itemPrice,
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
                          icon: isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          size: 50,
                        ),

                        const SizedBox(width: 50),
                        Expanded(
                          child: CustomElevatedButton(
                            onPressed: () {
                              if (quantity == 0) {
                                ref
                                    .read(basketProvider.notifier)
                                    .removeItem(widget.itemId);
                              } else {
                                ref
                                    .read(basketProvider.notifier)
                                    .addItem(
                                      BasketItem(
                                        id: widget.itemId,
                                        title: widget.itemTitle,
                                        imageUrl: widget.itemImage,
                                        price: widget.itemPrice,
                                        quantity: quantity,
                                        color: widget.itemColor,
                                      ),
                                    );
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Basket updated!')),
                              );
                            },
                            title: 'Add to Cart',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
