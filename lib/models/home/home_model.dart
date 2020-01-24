import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum HomeModelStatus {
  Ended,
  Loading,
}

class HomeModel extends ChangeNotifier {
  HomeModelStatus _status;
  HomeModelStatus get status => _status;

  List<UserData> _photos = [];
  List<UserData> get photos => _photos;

  HomeModel();

  HomeModel.instance() {
    getter();
  }

  void getter() async {
    _status = HomeModelStatus.Loading;
    notifyListeners();
    _photos = await UserData.fetchUserData(http.Client());
    _status = HomeModelStatus.Ended;
    notifyListeners();
  }

  void setter() {
    _status = HomeModelStatus.Loading;
    notifyListeners();

    _status = HomeModelStatus.Ended;
    notifyListeners();
  }

  void update() {
    _status = HomeModelStatus.Loading;
    notifyListeners();

    _status = HomeModelStatus.Ended;
    notifyListeners();
  }

  void remove() {
    _status = HomeModelStatus.Loading;
    notifyListeners();

    _status = HomeModelStatus.Ended;
    notifyListeners();
  }
}

class UserData {
  final int id;
  final String username;
  final String avatar;

  UserData({this.id, this.username, this.avatar});

  factory UserData.fromJson(Map<String, dynamic> json) {
    // String _avatar = json['avatar'].toString();
    String _avatar = 'https://i.pravatar.cc/300?u=' + json['name'].toString();

    return UserData(
      id: json['id'] as int,
      username: json['name'] as String,
      // avatar: _avatar.substring(0, _avatar.indexOf('?')),
      avatar: _avatar,
    );
  }

  static List<UserData> parseUserData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<UserData>((json) => UserData.fromJson(json)).toList();
  }

  static Future<List<UserData>> fetchUserData(http.Client client) async {
    final response =
      // await client.get('https://jsonplaceholder.typicode.com/photos');
      // await client.get('https://api.randomuser.me/?inc=login,email,picture&results=50&noinfo');
      await client.get('https://api.mockaroo.com/api/6a95ca80?count=20&key=6a6c8690');
    return compute(parseUserData, response.body);
  }
}
