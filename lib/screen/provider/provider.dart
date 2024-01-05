import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class BreadCrumb {
  bool isActive;
  final String name;
  final String uuid;
  BreadCrumb({
    required this.name,
    required this.isActive,
  }) : uuid = const Uuid().v4();

  void activate() {
    isActive = true;
  }

  @override
  bool operator ==(covariant BreadCrumb other) =>
      isActive == other.isActive && name == other.name;

  @override
  int get hashCode => uuid.hashCode;

  String get title => name + (isActive ? ' > ' : '');
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];
  UnmodifiableListView<BreadCrumb> get item => UnmodifiableListView(_items);

  void add(BreadCrumb breadCrumb) {
    for (var item in _items) {
      item.activate();
    }
    _items.add(breadCrumb);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    notifyListeners();
  }
}

class BreadCrumbsWidget extends StatelessWidget {
  const BreadCrumbsWidget({super.key, required this.breadCrumbs});
  final UnmodifiableListView<BreadCrumb> breadCrumbs;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: breadCrumbs.map((breadCrumb) {
        return Text(
          breadCrumb.title,
          style: TextStyle(
            color: breadCrumb.isActive ? Colors.blue : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BreadCrumbProvider(),
      builder: (context, builder) {
        return Scaffold(
          appBar: AppBar(title: const Text("Provider")),
          body: Column(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('add new bread crumb'),
              ),
              TextButton(
                onPressed: () {
                  context.read<BreadCrumbProvider>().reset();
                },
                child: const Text('Reset'),
              )
            ],
          ),
        );
      },
    );
  }
}
