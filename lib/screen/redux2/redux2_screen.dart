// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

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
      : uuid = json['uuid'] as String,
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

class Redux2Screen extends StatelessWidget {
  const Redux2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Redux2"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
