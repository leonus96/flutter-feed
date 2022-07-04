import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_rss/domain/articles_api/articles_api.dart';
import 'package:rxdart/subjects.dart';
import 'package:webfeed/webfeed.dart';

// TODO: podemos abstraer Rss feed para solo poder configurar la ruta... (Dev.to, Medium, etc).
class DevToArticlesApi extends ArticlesApi {
  final Dio _client;
  final _todoStreamController = BehaviorSubject<List<RssItem>>.seeded(const []);

  DevToArticlesApi({required Dio client}) : _client = client {
    _init();
  }

  void _init() async {
    final response = await _client.get(rssProviderUri);
    final feed = RssFeed.parse(response.data);
    if (feed.items?.isEmpty ?? true) {
      _todoStreamController.add(const []);
    } else {
      _todoStreamController.add(feed.items!);
    }
  }

  @override
  String get rssProviderUri => 'https://dev.to/feed/tag/flutter';

  @override
  Stream<List<RssItem>> getArticles() =>
      _todoStreamController.asBroadcastStream();
}
