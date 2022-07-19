import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rss/presentation/bookmarks/view/bookmarks_page.dart';
import 'package:flutter_rss/presentation/feed/view/feed_page.dart';
import 'package:flutter_rss/presentation/home/cubit/home_cubit.dart';
import 'package:flutter_rss/presentation/settings/view/settings_page.dart';
import 'package:flutter_rss/presentation/user/view/user_page.dart';
import 'package:iconsax/iconsax.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
          children: const [
            FeedPage(),
            BookmarksPage(),
            SettingsPage(),
            UserPage()
          ],
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
        child: SalomonBottomBar(
          currentIndex: selectedTab.index,
          onTap: (i) => context.read<HomeCubit>().setTab(HomeTab.values[i]),
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Iconsax.home),
                title: const Text('Feed'),
                selectedColor: Colors.blue),
            SalomonBottomBarItem(
                icon: const Icon(Iconsax.heart),
                title: const Text('Bookmarks'),
                selectedColor: Colors.red),
            SalomonBottomBarItem(
              icon: const Icon(Iconsax.setting),
              title: const Text('Settings'),
              selectedColor: Colors.green,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Iconsax.user),
              title: const Text('Settings'),
              selectedColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
