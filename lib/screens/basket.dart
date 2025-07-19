import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruitapp/components/custom_back_button.dart';
import 'package:fruitapp/components/custom_elevated_button.dart';
import 'package:fruitapp/components/custom_outlined_button.dart';
import 'package:fruitapp/components/custom_text_field.dart';
import 'package:fruitapp/constants.dart';
import 'package:fruitapp/provider/basket_provider.dart';
import 'package:fruitapp/screens/order_complete.dart';
import 'package:intl/intl.dart';

class Basket extends ConsumerStatefulWidget {
  const Basket({super.key});

  @override
  ConsumerState<Basket> createState() => _BasketState();
}

class _BasketState extends ConsumerState<Basket> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cardHolderName = TextEditingController();
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController cardExpiry = TextEditingController();
  final TextEditingController cardCvc = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> cardInfoFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    addressController.dispose();
    phoneController.dispose();
    cardHolderName.dispose();
    cardNumber.dispose();
    cardExpiry.dispose();
    cardCvc.dispose();
    super.dispose();
  }

  void showCheckoutBottomSheet(BuildContext context) {
    bool showCardForm = false;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 70),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: showCardForm
                      ? cardPaymentForm(context)
                      : checkoutForm(context, () {
                          setState(() {
                            showCardForm = true;
                          });
                        }),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.close, size: 28),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget checkoutForm(BuildContext context, VoidCallback onCardTap) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text(
            'Delivery Address',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hintText: '10th avenue, Lekki, Lagos State',
            controller: addressController,
          ),
          const SizedBox(height: 20),
          Text(
            'Number we can call',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hintText: '09090605708',
            controller: phoneController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 30),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        ref.read(basketProvider.notifier).clearBasket();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderComplete(),
                          ),
                        );
                      }
                    },

                    title: 'Pay on delivery',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CustomOutlinedButton(
                    onPressed: onCardTap,
                    title: 'Pay with card',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardPaymentForm(BuildContext context) {
    return Form(
      key: cardInfoFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          CustomTextField(
            title: 'Card Holder Name',
            hintText: 'Card Holder Name',
            controller: cardHolderName,
          ),
          CustomTextField(
            title: 'Card Number',
            hintText: '1234 5678 9012 1314',
            controller: cardNumber,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  title: 'Date',
                  hintText: '10/30',
                  controller: cardExpiry,
                  keyboardType: TextInputType.datetime,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomTextField(
                  title: 'CVC',
                  hintText: '123',
                  controller: cardCvc,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                          side: BorderSide(color: kPrimaryColor),
                          foregroundColor: kPrimaryColor,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          if (cardInfoFormKey.currentState?.validate() ??
                              false) {
                            ref.read(basketProvider.notifier).clearBasket();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrderComplete(),
                              ),
                            );
                          }
                        },
                        child: Text('Complete Order'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final basketItems = ref.watch(basketProvider);
    final formatter = NumberFormat('#,###');

    final totalPrice = basketItems.fold<int>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: kPrimaryColor,
            padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 10),
            child: Row(
              children: [
                const CustomBackButton(),
                const SizedBox(width: 20),
                Text(
                  'My Basket',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (basketItems.isEmpty)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Your basket is empty',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemCount: basketItems.length,
                separatorBuilder: (_, __) =>
                    Divider(color: Colors.grey.shade300),
                itemBuilder: (context, index) {
                  final item = basketItems[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: basketItems[index].color,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(item.imageUrl, height: 50),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontSize: 16, color: Colors.black),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${item.quantity} pack${item.quantity > 1 ? "s" : ""}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '₦ ${formatter.format(item.price * item.quantity)}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar: basketItems.isNotEmpty
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Text(
                      'Total\n₦ ${formatter.format(totalPrice)}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: CustomElevatedButton(
                        onPressed: () {
                          showCheckoutBottomSheet(context);
                        },
                        title: 'Checkout',
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
