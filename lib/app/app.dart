import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rss/presentation/home/home.dart';
import 'package:flutter_rss/repository/articles_repository/articles_repository.dart';
import 'package:flutter_rss/theme.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.articlesRepository}) : super(key: key);

  final ArticlesRepository articlesRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: articlesRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterNewsTheme.light(context),
      darkTheme: FlutterNewsTheme.dark(context),
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
