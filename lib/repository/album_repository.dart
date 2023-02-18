import 'dart:convert';

import 'package:flutter_demo_test/models/album.dart';
import 'package:http/http.dart' as http;

abstract class AlbumRepository {
  Future<Album> fetchAlbum();
}

class AlbumRepositoryImp implements AlbumRepository {
  final http.Client client;
  AlbumRepositoryImp(this.client);

  @override
  Future<Album> fetchAlbum() async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
