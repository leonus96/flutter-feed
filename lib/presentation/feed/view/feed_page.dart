import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rss/application/repository/articles_repository/articles_repository.dart';
import 'package:flutter_rss/presentation/feed/bloc/articles_bloc.dart';
import 'package:flutter_rss/presentation/feed/view/feed_item.dart';
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
                    delegate: SliverChildBuilderDelegate((_, index) {
                      if (index == 0) {
                        return const _FeedPageAppBar();
                      }
                      return FeedItem(
                        article: articles[index - 1],
                      );
                    }, childCount: articles.length),
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

class _FeedPageAppBar extends StatelessWidget {
  const _FeedPageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Row(
        children: [
          const FlutterLogo(
            size: 56,
          ),
          FlutterFeedTheme.separatorMH(),
          SizedBox(
            height: 72,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back! 👋',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.grey, fontSize: 20),
                ),
                Text(
                  'Flutter Developer',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: FlutterFeedTheme.isLight(context)
                            ? Colors.black
                            : Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
