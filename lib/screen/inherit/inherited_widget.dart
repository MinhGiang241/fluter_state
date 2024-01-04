import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class InheritedWigdetScreen extends StatefulWidget {
  const InheritedWigdetScreen({super.key});

  @override
  State<InheritedWigdetScreen> createState() => _InheritedWigdetScreenState();
}

class _InheritedWigdetScreenState extends State<InheritedWigdetScreen> {
  @override
  Widget build(BuildContext context) {
    return ApiProvider(
      api: Api(),
      child: const HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  ValueKey _textKey = const ValueKey<String?>(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(ApiProvider.of(context).api.dateAndTime ?? '')),
      body: GestureDetector(
        onTap: () async {
          final api = ApiProvider.of(context).api;
          final dateAndTime = await api.getDateAndTime();
          setState(() {
            _textKey = ValueKey(dateAndTime);
          });
        },
        child: SizedBox.expand(child: DateTimeWidget(key: _textKey)),
      ),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return Text(api.dateAndTime ?? 'Tap on screen to fetch date and time');
  }
}

class Api {
  String? dateAndTime;

  Future<String> getDateAndTime() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => DateTime.now().toIso8601String(),
    ).then((value) {
      dateAndTime = value;
      return value;
    });
  }
}

class ApiProvider extends InheritedWidget {
  ApiProvider({
    required this.api,
    required Widget child,
    Key? key,
  })  : uuid = const Uuid().v4(),
        super(key: key, child: child);
  final Api api;
  final String uuid;

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return uuid != oldWidget.uuid;
  }

  static ApiProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}
