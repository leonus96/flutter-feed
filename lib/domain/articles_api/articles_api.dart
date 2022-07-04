import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

abstract class ArticlesApi {
  const ArticlesApi();

  @protected
  String get rssProviderUri;

  Stream<List<RssItem>> getArticles();
}