import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rss/presentation/articles/view/articles_page.dart';
import 'package:flutter_rss/presentation/bookmarks/view/bookmarks_page.dart';
import 'package:flutter_rss/presentation/home/cubit/home_cubit.dart';
import 'package:flutter_rss/presentation/settings/view/settings_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: IndexedStack(
          index: selectedTab.index,
          children: const [ArticlesPage(), BookmarksPage(), SettingsPage()],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey[400]!,
            width: 0.5,
          ),
        )),
        child: BottomAppBar(
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.articles,
                icon: const Icon(FontAwesomeIcons.readme),
              ),
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.bookmarks,
                icon: const Icon(FontAwesomeIcons.solidHeart),
              ),
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.settings,
                icon: const Icon(FontAwesomeIcons.sliders),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: () => context.read<HomeCubit>().setTab(value),
      iconSize: 24,
      color:
          groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
