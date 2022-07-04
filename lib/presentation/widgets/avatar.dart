import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rss/application/repository/avatar_repository/avatar_repository.dart';

const kDefaultUsername = 'user_dev';

class Avatar extends StatelessWidget {
  final double? radius;
  final String? username;

  const Avatar({Key? key, this.username, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articlesRepository = context.read<AvatarRepository>();
    return FutureBuilder(
      future: articlesRepository.getAvatar(username ?? kDefaultUsername),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Container();
          case ConnectionState.done:
            return CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data!),
              backgroundColor: Colors.transparent,
              radius: radius,
            );
        }
      },
    );
  }
}
