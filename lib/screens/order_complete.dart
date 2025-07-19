import 'package:flutter/material.dart';
import 'package:fruitapp/components/custom_elevated_button.dart';
import 'package:fruitapp/components/custom_outlined_button.dart';
import 'package:fruitapp/screens/delivery_status.dart';

class OrderComplete extends StatelessWidget {
  const OrderComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                border: Border.all(color: Colors.green, width: 2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Congratulations!!!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Your order have been taken and is being attended to',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 19),
            ),
            const SizedBox(height: 40),
            CustomElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeliveryStatus()),
              ),
              title: 'Track Order',
            ),
            const SizedBox(height: 40),
            CustomOutlinedButton(
              onPressed: () => Navigator.pop(context),
              title: 'Continue Shopping',
            ),
          ],
        ),
      ),
    );
  }
}
