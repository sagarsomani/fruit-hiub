import 'package:flutter/material.dart';
import 'package:fruitapp/components/custom_back_button.dart';
import 'package:fruitapp/constants.dart';

class DeliveryStatus extends StatelessWidget {
  const DeliveryStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: kPrimaryColor,
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            child: Row(
              children: [
                const CustomBackButton(),
                const SizedBox(width: 20),
                Text(
                  'Delivery Status',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                orderStatusRow(
                  context,
                  'Order Taken',
                  'assets/order_taken.png',
                  Icons.check_circle,
                  Color(0xFFFFFAEB),
                  Colors.green,
                ),
                dottedLines(),
                orderStatusRow(
                  context,
                  'Order Is Being Prepared',
                  'assets/preparing_order.png',
                  Icons.check_circle,
                  Color(0xFFF1EFF6),
                  Colors.green,
                ),
                dottedLines(),
                orderStatusRow(
                  context,
                  'Order Is Being Delivered',
                  'assets/delivery_man.png',
                  Icons.call,
                  Color(0xFFFEF0F0),
                  kPrimaryColor,
                ),
                dottedLines(),
                Image.asset(
                  'assets/maps.png',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                dottedLines(),
                orderStatusRow(
                  context,
                  'Order Received',
                  'assets/order_delivered.png',
                  Icons.more_horiz,
                  Color(0xFFE8F5E9),
                  kPrimaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget dottedLines() {
  return Padding(
    padding: const EdgeInsets.only(left: 40.0),
    child: SizedBox(
      height: 30,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final dotCount = (constraints.maxHeight / 10).floor();
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dotCount, (context) {
              return Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.rectangle,
                ),
              );
            }),
          );
        },
      ),
    ),
  );
}

Widget orderStatusRow(
  BuildContext context,
  String status,
  String imagePath,
  IconData icon,
  Color backgroundColor,
  Color iconColor,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Center(
          child: status != 'Order Received'
              ? Image.asset(imagePath, width: 60, fit: BoxFit.contain)
              : Icon(Icons.check_circle, color: Colors.green),
        ),
      ),
      const SizedBox(width: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 18),
          ),
          if (status == 'Order Is Being Delivered')
            Text(
              'Your delivery agent is coming',
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
      const Spacer(),
      Icon(icon, size: 36, color: iconColor),
    ],
  );
}
