import 'dart:math';

import 'package:flutter/material.dart';

const _kAvatarProvider = 'https://api.multiavatar.com/';

class Avatar extends StatelessWidget {
  final String? seed;

  const Avatar({Key? key, this.seed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$_kAvatarProvider${seed ?? Random().nextInt(100)}.png',
    );
  }
}
