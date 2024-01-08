import 'package:flutter/material.dart';
import 'package:state/screen/basic/state_basic.dart';

import '../screen/inherit/inherited_widget.dart';
import '../screen/inherit_model/inherited_model_screen.dart';
import '../screen/inherited_notifier/notifier.dart';
import '../screen/provider/provider.dart';
import '../screen/provider2/provider_screen2.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        ListTile(
          title: const Text("Basic "),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const StateBasic()));
          },
        ),
        ListTile(
          title: const Text('Inherit'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const InheritedWigdetScreen()));
          },
        ),
        ListTile(
          title: const Text('Inherit model'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const InheritedModelScreen()));
          },
        ),
        ListTile(
          title: const Text('Inherit notifier'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const InheritedNotifierScreen()));
          },
        ),
        ListTile(
          title: const Text('Provider'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProviderScreen()));
          },
        ),
        ListTile(
          title: const Text('Provider2'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProviderScreen2()));
          },
        )
      ]),
    );
  }
}
