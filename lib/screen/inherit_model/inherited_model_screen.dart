import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class InheritedModelScreen extends StatefulWidget {
  const InheritedModelScreen({super.key});

  @override
  State<InheritedModelScreen> createState() => _InheritedModelScreenState();
}

class _InheritedModelScreenState extends State<InheritedModelScreen> {
  var color1 = Colors.yellow;
  var color2 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Model')),
      body: AvailableColorsWidget(
        color1: color1,
        color2: color2,
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        color1 = colors.getRandomElement();
                      });
                    },
                    child: const Text('Change color1')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        color2 = colors.getRandomElement();
                      });
                    },
                    child: const Text('Change color2')),
              ],
            ),
            const ColorWidget(color: AvailableColors.one),
            const ColorWidget(color: AvailableColors.two),
          ],
        ),
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.color});
  final AvailableColors color;

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case AvailableColors.one:
        devtools.log("Color1 widget got rebuilt!");
        break;
      case AvailableColors.two:
        devtools.log("Color2 widget got rebuilt!");
        break;
      default:
    }

    final provider = AvailableColorsWidget.of(context, color);
    return Container(
      height: 100,
      color: color == AvailableColors.one ? provider.color1 : provider.color2,
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

  final MaterialColor color1;
  final MaterialColor color2;

  static AvailableColorsWidget of(
      BuildContext context, AvailableColors aspect) {
    return InheritedModel.inheritFrom<AvailableColorsWidget>(context,
        aspect: aspect)!;
  }

  @override
  bool updateShouldNotify(covariant AvailableColorsWidget oldWidget) {
    devtools.log("updateShouldNotify");
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(covariant AvailableColorsWidget oldWidget,
      Set<AvailableColors> dependencies) {
    devtools.log("updateShouldNotifyDependent");
    if (dependencies.contains(AvailableColors.one) &&
        color1 != oldWidget.color1) {
      return true;
    }
    if (dependencies.contains(AvailableColors.two) &&
        color1 != oldWidget.color2) {
      return true;
    }

    return false;
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
