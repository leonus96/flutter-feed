import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rss/bootstrap.dart';
import 'package:flutter_rss/data/dev_to_articles_api/dev_to_articles_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final articlesApis = [DevToArticlesApi(client: Dio())];

  bootstrap(articlesApis: articlesApis);
}