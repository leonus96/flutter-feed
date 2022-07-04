import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rss/app/app.dart';
import 'package:flutter_rss/app/app_bloc_observer.dart';
import 'package:flutter_rss/domain/articles_api/articles_api.dart';
import 'package:flutter_rss/repository/articles_repository/articles_repository.dart';

void bootstrap({required List<ArticlesApi> articlesApis}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final articlesRepository = ArticlesRepository(articlesApis: articlesApis);

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          App(articlesRepository: articlesRepository),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
