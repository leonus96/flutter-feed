part of 'articles_bloc.dart';

abstract class ArticlesEvent extends Equatable {
  const ArticlesEvent();

  @override
  List<Object> get props => [];
}

class ArticlesSubscriptionRequested extends ArticlesEvent {
  const ArticlesSubscriptionRequested();
}
