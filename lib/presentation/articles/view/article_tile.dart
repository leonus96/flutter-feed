import 'package:flutter/material.dart';
import 'package:flutter_rss/presentation/widgets/avatar.dart';
import 'package:flutter_rss/theme.dart';
import 'package:intl/intl.dart';
import 'package:webfeed/webfeed.dart';

class ArticleTile extends StatelessWidget {
  final RssItem article;

  const ArticleTile({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CategoriesArticleTile(
              categories: article.categories!,
            ),
            Text(
              article.title ?? '-',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            _FooterArticleTile(
              article: article,
            )
          ],
        ),
      ),
    );
  }
}

class _CategoriesArticleTile extends StatelessWidget {
  final List<RssCategory> categories;

  const _CategoriesArticleTile({Key? key, required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.caption;
    return SizedBox(
      height: 20,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) =>
            isFlutter(categories[index])
                ? Container()
                : Text(
                    categories[index].value.toUpperCase(),
                    style: textStyle,
                  ),
        separatorBuilder: (BuildContext context, int index) =>
            isFlutter(categories[index])
                ? Container()
                : const _MiddlePointerSeparator(),
        itemCount: categories.length,
      ),
    );
  }

  bool isFlutter(RssCategory category) {
    return category.value.toUpperCase() == 'FLUTTER';
  }
}

class _FooterArticleTile extends StatelessWidget {
  final RssItem article;

  const _FooterArticleTile({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format = DateFormat('dd/mm/yyyy');
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Avatar(
                radius: 16,
                username: article.dc?.creator,
              ),
              FlutterNewsTheme.separatorMH(),
              Text(
                article.dc!.creator ?? '-',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const _MiddlePointerSeparator(),
              Text(
                format.format(article.pubDate!),
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
          TextButton(onPressed: () {}, style: TextButton.styleFrom(
            minimumSize: const Size(32, 16),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,

          ), child: const Text('Save'),)
        ],
      ),
    );
  }
}

class _MiddlePointerSeparator extends StatelessWidget {
  const _MiddlePointerSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '·',
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
