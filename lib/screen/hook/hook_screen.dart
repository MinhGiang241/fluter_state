import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HookScreen extends StatelessWidget {
  const HookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dateTime = useStream(getTime());
    return Scaffold(
      appBar: AppBar(title: const Text("Hook")),
      body: const Column(
        children: [],
      ),
    );
  }
}

Stream<String> getTime() => Stream.periodic(
    const Duration(seconds: 1), (_) => DateTime.now().toIso8601String());
