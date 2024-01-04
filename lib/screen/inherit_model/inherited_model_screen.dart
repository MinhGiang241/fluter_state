import 'dart:math';

import 'package:flutter/material.dart';

class InheritedModelScreen extends StatefulWidget {
  const InheritedModelScreen({super.key});

  @override
  State<InheritedModelScreen> createState() => _InheritedModelScreenState();
}

class _InheritedModelScreenState extends State<InheritedModelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Model')),
      body: Column(),
    );
  }
}

class AvailableColorsWidget extends InheritedModel<AvailableColors> {
  const AvailableColorsWidget({
    super.key,
    required super.child,
    required this.color1,
    required this.color2,
  });

  final AvailableColors color1;
  final AvailableColors color2;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw UnimplementedError();
  }

  @override
  bool updateShouldNotifyDependent(
      covariant InheritedModel<AvailableColors> oldWidget,
      Set<AvailableColors> dependencies) {
    throw UnimplementedError();
  }
}

enum AvailableColors { one, two }

final colors = [
  Colors.blue,
  Colors.red,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.cyan,
  Colors.brown,
  Colors.amber,
  Colors.deepPurple,
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(Random().nextInt(length));
}
