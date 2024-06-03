import 'package:flutter/material.dart';
import 'package:harcum1/screens/menu.dart';
import 'package:provider/provider.dart';
import 'card_item.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: const MyApp(),
    ),
  );
}