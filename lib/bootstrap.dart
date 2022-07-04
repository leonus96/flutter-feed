import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rss/application/app.dart';
import 'package:flutter_rss/application/app_bloc_observer.dart';
import 'package:flutter_rss/application/repository/articles_repository/articles_repository.dart';
import 'package:flutter_rss/application/repository/avatar_repository/avatar_repository.dart';
import 'package:flutter_rss/domain/articles_api/articles_api.dart';
import 'package:flutter_rss/domain/avatar_service/avatar_service.dart';

void bootstrap({required List<ArticlesApi> articlesApis, required AvatarService avatarService}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final articlesRepository = ArticlesRepository(articlesApis: articlesApis);
  final avatarRepository = AvatarRepository(service: avatarService);

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          App(articlesRepository: articlesRepository, avatarRepository: avatarRepository,),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
