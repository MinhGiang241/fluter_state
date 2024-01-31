// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

const apiUrl = 'https://random-data-api.com/api/v2/users?size=2&is_xml=true';

@immutable
class Person {
  final String uuid;
  final int id;
  final String first_name;
  final String last_name;
  final String email;
  final String avatar;
  const Person({
    required this.uuid,
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.avatar,
  });
  Person.fromJson(Map<String, dynamic> json)
      : uuid = json['uid'] as String,
        id = json['id'] as int,
        first_name = json['first_name'] as String,
        last_name = json['last_name'] as String,
        email = json['email'] as String,
        avatar = json['avatar'] as String;

  @override
  String toString() => "Person ($first_name $last_name )";
}

Future<Iterable<Person>> getPerson() => HttpClient()
    .getUrl(Uri.parse(apiUrl))
    .then((req) => req.close())
    .then((res) => res.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

@immutable
abstract class Action {
  const Action();
}

@immutable
class LoadPeopleAction extends Action {
  const LoadPeopleAction();
}

@immutable
class SucessfullyFetchedPeopleAction extends Action {
  final Iterable<Person> persons;

  const SucessfullyFetchedPeopleAction({required this.persons});
}

@immutable
class FailedToFetchPeopleAction extends Action {
  final Object error;

  const FailedToFetchPeopleAction({required this.error});
}

@immutable
class State {
  final bool isLoading;
  final Iterable<Person>? fetchedPersons;
  final Object? error;

  const State(
      {required this.isLoading,
      required this.fetchedPersons,
      required this.error});

  const State.empty()
      : isLoading = false,
        fetchedPersons = null,
        error = null;
}

State reducer(State oldState, action) {
  if (action is LoadPeopleAction) {
    return const State(
      error: null,
      fetchedPersons: null,
      isLoading: true,
    );
  } else if (action is SucessfullyFetchedPeopleAction) {
    return State(
      isLoading: false,
      fetchedPersons: action.persons,
      error: null,
    );
  } else if (action is FailedToFetchPeopleAction) {
    return State(
      error: action.error,
      fetchedPersons: oldState.fetchedPersons,
      isLoading: false,
    );
  }
  return oldState;
}

void loadPeopleMiddleware(Store<State> store, action, NextDispatcher next) {
  if (action is LoadPeopleAction) {
    getPerson().then((persons) {
      store.dispatch(SucessfullyFetchedPeopleAction(persons: persons));
    }).catchError((e) {
      store.dispatch(FailedToFetchPeopleAction(error: e));
    });
  }
  next(action);
}

class Redux2Screen extends StatelessWidget {
  const Redux2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Store(
      reducer,
      initialState: const State.empty(),
      middleware: [loadPeopleMiddleware],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Redux2"),
      ),
      body: StoreProvider(
        store: store,
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                store.dispatch(const LoadPeopleAction());
              },
              child: const Text("Load persons"),
            ),
            StoreConnector<State, bool>(
                builder: (context, isLoading) {
                  if (isLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return const SizedBox();
                  }
                },
                converter: (store) => store.state.isLoading),
            StoreConnector<State, Iterable<Person>?>(
              builder: (context, people) {
                if (people == null) {
                  return const SizedBox();
                }
                return Expanded(
                    child: ListView.builder(
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    final person = people.elementAt(index);
                    return ListTile(
                      title: Text(person.last_name),
                      subtitle: Text(person.email),
                    );
                  },
                ));
              },
              converter: (store) => store.state.fetchedPersons,
            )
          ],
        ),
      ),
    );
  }
}
