import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LotieScreen extends StatelessWidget {
  const LotieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lotie")),
      body: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 18,
          crossAxisSpacing: 15,
          childAspectRatio: 1,
          children: [
            Lottie.asset(
              'assets/lottie/flower.json',
              fit: BoxFit.contain,
            ),
            Lottie.asset(
              'assets/lottie/car.json',
              fit: BoxFit.contain,
            ),
            Lottie.asset(
              'assets/lottie/bird.json',
              fit: BoxFit.contain,
            ),
            Lottie.asset(
              'assets/lottie/404.json',
              fit: BoxFit.contain,
            ),
            Lottie.asset(
              'assets/lottie/firework.json',
              fit: BoxFit.contain,
            ),
            Lottie.asset(
              'assets/lottie/house.json',
              fit: BoxFit.contain,
            ),
          ]),
    );
  }
}
