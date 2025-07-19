import 'package:flutter/material.dart';
import 'package:fruitapp/constants.dart';

class FruitBasketDisplay extends StatelessWidget {
  final String imagePath;
  final int size;

  const FruitBasketDisplay({
    super.key,
    required this.imagePath,
    required this.size,
  });

  // Optional: Preview constructor for debugging or widget previews
  const FruitBasketDisplay.preview({super.key})
    : imagePath = 'assets/fruit_basket2.png',
      size = 250;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: const BoxDecoration(color: kPrimaryColor),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              imagePath,
              width: size.toDouble(),
              height: size.toDouble(),
            ),
            Container(
              height: 10,
              width: size.toDouble(),
              decoration: const BoxDecoration(
                color: Color(0xFFF08626),
                borderRadius: BorderRadius.all(Radius.elliptical(150, 9)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
