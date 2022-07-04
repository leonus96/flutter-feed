import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_rss/domain/avatar_service/avatar_service.dart';

class Dashatar extends AvatarService {
  final Dio _client;

  Dashatar({required Dio client}) : _client = client;

  @override
  String get providerUrl =>
      'https://us-central1-dashatar-dev.cloudfunctions.net/createDashatar';

  @override
  Future<String?> buildAvatar(String seed) async {
    const role = 'developer';
    final random = Random(seed.hashCode);
    final params = _getParamPoints(random);
    final response = await _client.get(providerUrl, queryParameters: {
      'agility': '${params[0]}',
      'wisdom': '${params[1]}',
      'strength': '${params[2]}',
      'charisma': '${params[3]}',
      'role': role,
    });

    return response.data['url'] as String;
  }

  List<int> _getParamPoints(Random random) {
    final List<int> params = [1, 1, 1, 1];
    for (var i = 0; i < 8; i++) {
      final index = random.nextInt(params.length - 1);
      if (params[index] < 5) {
        params[index] = params[index] + 1;
      }
    }

    return params;
  }
}
