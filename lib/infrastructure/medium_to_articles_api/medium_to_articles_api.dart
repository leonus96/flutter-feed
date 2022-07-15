import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_rss/domain/articles_api/articles_api.dart';
import 'package:rxdart/subjects.dart';
import 'package:webfeed/webfeed.dart';

// TODO: podemos abstraer Rss feed para solo poder configurar la ruta... (Dev.to, Medium, etc).
class MediumToArticlesApi extends ArticlesApi {
  final Dio _client;
  final _articlesStreamController = BehaviorSubject<List<RssItem>>.seeded(const []);

  MediumToArticlesApi({required Dio client}) : _client = client {
    _init();
  }

  void _init() async {
    final response = await _client.get(rssProviderUri);
    final feed = RssFeed.parse(response.data);
    if (feed.items?.isEmpty ?? true) {
      _articlesStreamController.add(const []);
    } else {
      _articlesStreamController.add(feed.items!);
    }
  }

  @override
  String get rssProviderUri => 'https://medium.com/feed/flutter';

  @override
  Stream<List<RssItem>> getArticles() =>
      _articlesStreamController.asBroadcastStream();
}
