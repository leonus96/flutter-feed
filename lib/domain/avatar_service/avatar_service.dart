import 'package:flutter/material.dart';

abstract class AvatarService {
  const AvatarService();

  @protected
  String get providerUrl;

  Future<String?> buildAvatar(String seed);
}