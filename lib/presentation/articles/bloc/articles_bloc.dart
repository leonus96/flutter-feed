import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rss/repository/articles_repository/articles_repository.dart';
import 'package:webfeed/domain/rss_item.dart';

part 'articles_state.dart';
part 'articles_event.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticlesRepository _articlesRepository;

  ArticlesBloc({
    required ArticlesRepository articlesRepository,
  })  : _articlesRepository = articlesRepository,
        super(const ArticlesState()) {
    on<ArticlesSubscriptionRequested>(_onSubscriptionRequested);
  }

  Future<void> _onSubscriptionRequested(
    ArticlesSubscriptionRequested event,
    Emitter<ArticlesState> emit,
  ) async {
    emit(state.copyWith(status: () => ArticlesStatus.loading));

    await emit.forEach<List<RssItem>>(
      _articlesRepository.getTodos(),
      onData: (articles) => state.copyWith(
        status: () => ArticlesStatus.success,
        articles: () => articles,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ArticlesStatus.failure,
      ),
    );
  }
}
