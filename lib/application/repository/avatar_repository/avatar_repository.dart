import 'package:flutter_rss/domain/avatar_service/avatar_service.dart';

class AvatarRepository {
  final AvatarService _service;

  AvatarRepository({required AvatarService service}) : _service = service;

  Future<String?> getAvatar(String username) => _service.buildAvatar(username);
}
