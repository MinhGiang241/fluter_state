import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HookCountDownScreen extends HookWidget {
  const HookCountDownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final countDown = useMemoized(() => CountDown(from: 20));
    final notifier = useListenable(countDown);
    return Scaffold(
      appBar: AppBar(title: const Text('count down')),
      body: Text(notifier.value.toString()),
    );
  }
}

class CountDown extends ValueNotifier<int> {
  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(
      const Duration(seconds: 1),
      (v) => from - v,
    ).takeWhile((value) => value >= 0).listen((value) {
      this.value = value;
    });
  }
  late StreamSubscription sub;

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
