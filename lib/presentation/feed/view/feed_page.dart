import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rss/application/repository/articles_repository/articles_repository.dart';
import 'package:flutter_rss/presentation/feed/bloc/articles_bloc.dart';
import 'package:flutter_rss/presentation/feed/view/feed_item.dart';
import 'package:flutter_rss/presentation/widgets/avatar.dart';
import 'package:flutter_rss/theme.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticlesBloc(
        articlesRepository: context.read<ArticlesRepository>(),
      )..add(const ArticlesSubscriptionRequested()),
      child: const ArticlesView(),
    );
  }
}

class ArticlesView extends StatelessWidget {
  const ArticlesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<ArticlesBloc, ArticlesState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == ArticlesStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Error!'),
                      ),
                    );
                }
              },
            ),
          ],
          child: CustomScrollView(
            slivers: [
              const _AppbarArticlePage(),
              BlocBuilder<ArticlesBloc, ArticlesState>(
                builder: (context, state) {
                  if (state.status == ArticlesStatus.loading) {
                    return SliverToBoxAdapter(
                      child: Container(),
                    );
                  }
                  if (state.articles.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Container(),
                    );
                  }

                  final articles = state.articles;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) => FeedItem(
                        article: articles[index],
                      ),
                      childCount: articles.length
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppbarArticlePage extends StatelessWidget {
  const _AppbarArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 64,
      titleSpacing: 4,
      title: Row(
        children: [
          const Avatar(radius: 32, username: 'Flutter Developer'),
          FlutterFeedTheme.separatorMH(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back! 👋',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey),
              ),
              //TODO: Centralizar colores.
              Text(
                'Flutter Developer',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
