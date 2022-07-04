import 'package:async/async.dart';
import 'package:flutter_rss/domain/articles_api/articles_api.dart';
import 'package:webfeed/domain/rss_item.dart';

class ArticlesRepository {
  final List<ArticlesApi> _articlesApis;

  const ArticlesRepository({required articlesApis})
      : _articlesApis = articlesApis;

  Stream<List<RssItem>> getTodos() =>
      StreamGroup.merge(_articlesApis.map((e) => e.getArticles()));
}
