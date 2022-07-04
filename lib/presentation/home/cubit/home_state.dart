part of 'home_cubit.dart';

enum HomeTab { articles, bookmarks, settings }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.articles,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}