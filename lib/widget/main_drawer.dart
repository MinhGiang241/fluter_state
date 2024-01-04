import 'package:flutter/material.dart';
import 'package:state/screen/basic/state_basic.dart';

import '../screen/inherit/inherited_widget.dart';
import '../screen/inherit_model/inherited_model_screen.dart';

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
        )
      ]),
    );
  }
}
