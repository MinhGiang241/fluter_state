import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const url = 'https://picsum.photos/640/425'; // 'https://bit.ly/3x7J5Qt';
const imageHeight = 300.0;

extension Normalize on num {
  num nomalized(
    num selfRangeMin,
    num selfRangeMax, [
    num normalizedRangeMin = 0.0,
    num nomarlizedRangeMax = 1.0,
  ]) =>
      (nomarlizedRangeMax - normalizedRangeMin) *
      ((this - selfRangeMin) / (selfRangeMax - selfRangeMin));
}

class HookScrollScreen extends HookWidget {
  const HookScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final opacity = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      upperBound: 1.0,
      lowerBound: 0.0,
    );

    final size = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      upperBound: 1.0,
      lowerBound: 0.0,
    );

    final controller = useScrollController();

    useEffect(() {
      controller.addListener(() {
        final newOpacity = max(imageHeight - controller.offset, 0.0);
        final normalized = newOpacity.nomalized(0.0, imageHeight).toDouble();
        opacity.value = normalized;
        size.value = normalized;
      });
      return null;
    }, [controller]);

    return Scaffold(
      appBar: AppBar(title: const Text("Scroll")),
      body: Column(
        children: [
          SizeTransition(
            sizeFactor: size,
            axis: Axis.vertical,
            axisAlignment: -1.0,
            child: FadeTransition(
              opacity: opacity,
              child: Image.network(
                url,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                controller: controller,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('Person ${index + 1}'));
                }),
          )
        ],
      ),
    );
  }
}
