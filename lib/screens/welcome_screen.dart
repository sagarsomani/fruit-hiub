import 'package:flutter/material.dart';
import 'package:fruitapp/components/custom_elevated_button.dart';
import 'package:fruitapp/components/fruit_basket_display.dart';
import 'package:fruitapp/screens/authentication_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FruitBasketDisplay(imagePath: 'assets/fruit_basket.png', size: 250),

          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Get The Freshest Fruit Salad Combo',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'We deliver the best and freshest fruit salad in town. Order for a combo today!!!',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 50),
                  CustomElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthenticationScreen(),
                        ),
                      );
                    },
                    title: "Let's Continue",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
