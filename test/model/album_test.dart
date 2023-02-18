// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
import 'package:flutter_demo_test/models/album.dart';
import 'package:flutter_demo_test/repository/album_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'album_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final client = MockClient();

  late AlbumRepositoryImp albumRepository;
  setUpAll(() {
    albumRepository = AlbumRepositoryImp(client);
  });
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async =>
              http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      expect(await albumRepository.fetchAlbum(), isA<Album>());
    });

    test('throws an exception if the http call completes with an error', () {
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(albumRepository.fetchAlbum(), throwsException);
    });
  });
}
