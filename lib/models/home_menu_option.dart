import 'package:flutter/material.dart';

class HomeMenuOption {
  final String id;
  final String title;
  final Icon icon;
  final String routeName;

  const HomeMenuOption({
    @required this.id,
    @required this.title,
    @required this.icon,
    @required this.routeName,
  });
}
