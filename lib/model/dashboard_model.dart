import 'package:flutter/material.dart';

class CardModel {
  Color? color;
  String? reminders;
  String? notes;

  CardModel(
      {required this.color, required this.reminders, required this.notes});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    final color = json['color'];
    final reminders = json['reminders'];
    final notes = json['notes'];
    return CardModel(color: color, reminders: reminders, notes: notes);
  }
}

class MenuModel {
  String? menu;
  String? imagePath;

  MenuModel(this.menu, this.imagePath);

  factory MenuModel.fromJson(Map<String, String> json) {
    final menu = json['menu'];
    final imagePath = json['imagePath'];
    return MenuModel(menu, imagePath);
  }
}
