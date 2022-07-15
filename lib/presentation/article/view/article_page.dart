import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rss/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:webviewx/webviewx.dart';

const _kScrollHeaderHidePx = 86;
const _kTitleHeightPx = 110.0;
const _kHeaderHideDurationMs = 500;
const _kPeriodicGetScrollYMs = 500;

class ArticlePage extends StatelessWidget {
  final RssItem article;

  const ArticlePage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ArticleView(
      article: article,
    );
  }
}

class _ArticleView extends StatefulWidget {
  final RssItem article;

  const _ArticleView({Key? key, required this.article}) : super(key: key);

  @override
  State<_ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<_ArticleView>
    with SingleTickerProviderStateMixin {
  late final WebViewXController _webviewController;
  late final Timer _timer;
  late final AnimationController _animationController;
  late final Animation _animation;
  final _heightTween = Tween<double>(begin: _kTitleHeightPx, end: 0);

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: _kHeaderHideDurationMs));
    _animation = _heightTween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animation.addListener(() => setState(() {}));

    Future.delayed(const Duration(milliseconds: _kHeaderHideDurationMs), () {
      _timer = Timer.periodic(
        const Duration(milliseconds: _kPeriodicGetScrollYMs),
        (timer) async {
          final webViewScrollOffset = await _webviewController.getScrollY();
          if (webViewScrollOffset >= _kScrollHeaderHidePx &&
              _animationController.status == AnimationStatus.dismissed) {
            _animationController.forward();
          }
          if (webViewScrollOffset < _kScrollHeaderHidePx &&
              _animationController.status == AnimationStatus.completed) {
            _animationController.reverse();
          }
        },
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(FontAwesomeIcons.heart)),
          IconButton(
              onPressed: () {}, icon: const Icon(FontAwesomeIcons.shareNodes)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(FlutterFeedTheme.paddingPxMH),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(FlutterFeedTheme.paddingPxMH),
              child: SizedBox(
                height: _animation.value,
                child: Text(
                  widget.article.title!,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 0.5, color: Colors.grey))),
                child: WebViewX(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  initialSourceType: SourceType.html,
                  initialContent: _buildContent(context),
                  onWebViewCreated: (controller) =>
                      _webviewController = controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildContent(BuildContext context) {
    return '${_buildStyles(context)} <div class="flutter_feed">'
        '${widget.article.content?.value ?? widget.article.description ?? '<h1>'
            'Error, no content 😩'
            '</h1>'} '
        '</div>';
  }

  String _buildStyles(BuildContext context) {
    final isLight =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return '''
      <style>
        * {
          background-color: ${isLight ? '#FAFAFA' : '#303030'};
          color: ${isLight ? 'black' : 'white'};
        }
        .flutter_feed {
          padding: 0;
          margin: 0;
          font-family: Verdana, Arial, Sans-Serif,serif;
          width: 100%;
        }
        
        .flutter_feed code {
          border: 1px solid #F6F6F6;
          color: ${isLight ? '#2F3337' : '#C9D1D9'};
          background: ${isLight ? '#E0E0E0' : '#161B22'};
          page-break-inside: avoid;
          font-family: monospace;
          font-size: 15px;
          line-height: 1.6;
          margin-bottom: 1.6em;
          max-width: 100%;
          overflow-x: auto;
          padding: 1em 1.5em;
          display: block;
          word-wrap: break-word;
          border-radius: 10px;
        }
        
        .flutter_feed img {
          width: 100%;
          max-width: 100vh;
          height: auto;
        }
        
        .flutter_feed p iframe, .flutter_feed p object, .flutter_feed p embed {
          height: 250px;
          left: 0;
          top: 0;
        }
      </style>
''';
  }
}
