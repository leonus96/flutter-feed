import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rss/bootstrap.dart';
import 'package:flutter_rss/infrastructure/dashatar/dashatar.dart';
import 'package:flutter_rss/infrastructure/dev_to_articles_api/dev_to_articles_api.dart';
import 'package:flutter_rss/infrastructure/medium_to_articles_api/medium_to_articles_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio();
  final articlesApis = [
    DevToArticlesApi(client: dio),
    MediumToArticlesApi(client: dio)
  ];
  final dashatar = Dashatar(client: dio);

  bootstrap(articlesApis: articlesApis, avatarService: dashatar);
}
