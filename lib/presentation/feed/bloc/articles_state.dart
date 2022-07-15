part of 'articles_bloc.dart';

enum ArticlesStatus { initial, loading, success, failure }

class ArticlesState extends Equatable {
  final ArticlesStatus status;
  final List<RssItem> articles;

  const ArticlesState({
    this.status = ArticlesStatus.initial,
    this.articles = const [],
  });

  ArticlesState copyWith({
    ArticlesStatus Function()? status,
    List<RssItem> Function()? articles,
  }) {
    return ArticlesState(
      status: status != null ? status() : this.status,
      articles: articles != null ? articles() : this.articles,
    );
  }

  @override
  List<Object?> get props => [
        status,
        articles,
      ];
}
