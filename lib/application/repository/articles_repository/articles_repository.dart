import 'package:flutter_rss/domain/articles_api/articles_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webfeed/domain/rss_item.dart';

class ArticlesRepository {
  final List<ArticlesApi> _articlesApis;
  final lastResponses = <ArticlesApi, List<RssItem>>{};
  final _articlesStreamController =
      BehaviorSubject<List<RssItem>>.seeded(const []);

  ArticlesRepository({required articlesApis}) : _articlesApis = articlesApis {
    _init();
  }

  void _init() {
    for (final articleApi in _articlesApis) {
      articleApi.getArticles().listen((response) {
        lastResponses[articleApi] = response;

        _articlesStreamController.add(
          lastResponses.values
              .expand((element) => element)
              .toList(growable: false),
        );
      });
    }
  }

  Stream<List<RssItem>> getTodos() =>
      _articlesStreamController.asBroadcastStream();
}
