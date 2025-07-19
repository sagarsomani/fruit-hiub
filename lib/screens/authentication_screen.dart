import 'package:flutter/material.dart';
import 'package:fruitapp/components/custom_elevated_button.dart';
import 'package:fruitapp/components/custom_text_field.dart';
import 'package:fruitapp/components/fruit_basket_display.dart';
import 'package:fruitapp/screens/home_page.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FruitBasketDisplay(
                    imagePath: 'assets/fruit_basket2.png',
                    size: 250,
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            title: 'What is your firstname?',
                            hintText: 'Tony',
                            controller: nameController,
                          ),
                          const SizedBox(height: 20),
                          CustomElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              ScaffoldMessenger.of(
                                context,
                              ).hideCurrentSnackBar();

                              if (nameController.text.isNotEmpty) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(userName: nameController.text),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter your name'),
                                  ),
                                );
                              }
                            },
                            title: "Start Ordering",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
