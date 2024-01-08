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
  UnmodifiableListView<BreadCrumb> get items => UnmodifiableListView(_items);

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

typedef OnBreadCrumbTapped = void Function(BreadCrumb);

class BreadCrumbsWidget extends StatelessWidget {
  const BreadCrumbsWidget(
      {super.key, required this.breadCrumbs, required this.onTap});
  final UnmodifiableListView<BreadCrumb> breadCrumbs;
  final OnBreadCrumbTapped onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: breadCrumbs.map((breadCrumb) {
        return GestureDetector(
          onTap: () {
            onTap(breadCrumb);
          },
          child: Text(
            breadCrumb.title,
            style: TextStyle(
              color: breadCrumb.isActive ? Colors.blue : Colors.black,
            ),
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
    var model = BreadCrumbProvider();
    return ChangeNotifierProvider(
      create: (_) => model,
      builder: (context, builder) {
        return Scaffold(
          appBar: AppBar(title: const Text("Provider")),
          body: Column(
            children: [
              Consumer<BreadCrumbProvider>(
                builder: (context, value, child) {
                  return BreadCrumbsWidget(
                    breadCrumbs: value.items,
                    onTap: (BreadCrumb breadCrumb) {},
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                      value: model,
                      child: const NewBreadCrumbWidget(),
                    ),
                  ));
                },
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

class NewBreadCrumbWidget extends StatefulWidget {
  const NewBreadCrumbWidget({super.key});

  @override
  State<NewBreadCrumbWidget> createState() => _NewBreadCrumbWidgetState();
}

class _NewBreadCrumbWidgetState extends State<NewBreadCrumbWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add new breadCrumb")),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Ennter a new bread crumb here ...',
            ),
          ),
          TextButton(
              onPressed: () {
                final text = _controller.text.trim();
                if (text.isNotEmpty) {
                  final breadCrumb = BreadCrumb(name: text, isActive: true);
                  context.read<BreadCrumbProvider>().add(breadCrumb);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add')),
        ],
      ),
    );
  }
}
