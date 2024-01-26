import 'package:flutter/material.dart';
import 'package:state/screen/basic/state_basic.dart';
import 'package:state/screen/hook_countdown/hook_countdown.dart';

import '../screen/hook/hook_screen.dart';
import '../screen/hook_image/hook_image_screen.dart';
import '../screen/hook_scroll/hook_scroll_screen.dart';
import '../screen/inherit/inherited_widget.dart';
import '../screen/inherit_model/inherited_model_screen.dart';
import '../screen/inherited_notifier/notifier.dart';
import '../screen/lotie/lotie_screen.dart';
import '../screen/provider/provider.dart';
import '../screen/provider2/provider_screen2.dart';
import '../screen/redux/redux_screen.dart';
import '../screen/redux2/redux2_screen.dart';

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
        ),
        ListTile(
          title: const Text('Hook'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HookScreen()));
          },
        ),
        ListTile(
          title: const Text('Hook Countdown'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HookCountDownScreen()));
          },
        ),
        ListTile(
          title: const Text('Hook Scroll'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HookScrollScreen()));
          },
        ),
        ListTile(
          title: const Text('Hook Image'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HookImageScreen()));
          },
        ),
        ListTile(
          title: const Text('Redux'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ReduxScreen()));
          },
        ),
        ListTile(
          title: const Text('Redux2'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Redux2Screen()));
          },
        ),
        ListTile(
          title: const Text('Lotie'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LotieScreen()));
          },
        ),
      ]),
    );
  }
}
