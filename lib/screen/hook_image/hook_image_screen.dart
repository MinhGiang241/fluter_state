import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const url = 'https://picsum.photos/640/425';

enum Action {
  rotateLeft,
  rotateRight,
  moreVisible,
  lessVisible,
}

@immutable
class State {
  final double rotationDeg;
  final double alpha;

  const State({required this.rotationDeg, required this.alpha});

  const State.zero()
      : rotationDeg = 0.0,
        alpha = 1.0;
  State rotateRight() => State(alpha: alpha, rotationDeg: rotationDeg + 10.0);
  State rotateLeft() => State(alpha: alpha, rotationDeg: rotationDeg - 10.0);
  State increaseAlpha() =>
      State(alpha: min(alpha + 0.1, 1.0), rotationDeg: rotationDeg);
  State decreaseAlpha() =>
      State(alpha: min(alpha - 0.1, 1.0), rotationDeg: rotationDeg);
}

State reducer(State oldState, Action? action) {
  switch (action) {
    case Action.rotateLeft:
      return oldState.rotateLeft();
    case Action.rotateRight:
      return oldState.rotateRight();
    case Action.moreVisible:
      return oldState.increaseAlpha();
    case Action.lessVisible:
      return oldState.decreaseAlpha();
    default:
      return oldState;
  }
}

class HookImageScreen extends HookWidget {
  const HookImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLifecycleState lifecycleState;
    final state = useAppLifecycleState();
    final store = useReducer<State, Action?>(
      reducer,
      initialState: const State.zero(),
      initialAction: null,
    );
    return Scaffold(
      appBar: AppBar(title: const Text("image")),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                RotateLeftButton(store: store),
                RotateRightButton(store: store),
                DecreaseAlphaButton(store: store),
                IncreaseButton(store: store),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Opacity(
            opacity: state == AppLifecycleState.resumed ? store.state.alpha : 0,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(
                store.state.rotationDeg / 360.0,
              ),
              child: Image.network(url),
            ),
          ),
        ],
      ),
    );
  }
}

class IncreaseButton extends StatelessWidget {
  const IncreaseButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        store.dispatch(Action.moreVisible);
      },
      child: const Text('Increase Alpha'),
    );
  }
}

class DecreaseAlphaButton extends StatelessWidget {
  const DecreaseAlphaButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        store.dispatch(Action.lessVisible);
      },
      child: const Text('Decrease Alpha'),
    );
  }
}

class RotateRightButton extends StatelessWidget {
  const RotateRightButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        store.dispatch(Action.rotateRight);
      },
      child: const Text('Rotate Right'),
    );
  }
}

class RotateLeftButton extends StatelessWidget {
  const RotateLeftButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        store.dispatch(Action.rotateLeft);
      },
      child: const Text('Rotate Left'),
    );
  }
}
