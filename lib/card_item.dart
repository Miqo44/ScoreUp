import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class CardItem {
  final String title;
  final String type;
  final String report;
  final String purpose;
  final String loanApplication;
  final String date;
  final DateTime dateTime;
  final String icon;
  final String affect;
  final String important;
  final String notImportant;
  final bool isImportant;
  final String search;
  final String queries;

  CardItem({
    required this.title,
    required this.type,
    required this.report,
    required this.purpose,
    required this.loanApplication,
    required this.date,
    required this.dateTime,
    required this.icon,
    required this.affect,
    required this.important,
    required this.notImportant,
    required this.isImportant,
    required this.search,
    required this.queries,
  });

  factory CardItem.fromJson(Map<String, dynamic> json, Map<String, dynamic> defaultValues, bool previousIsImportant) {
    return CardItem(
      title: json['title'] ?? defaultValues['defaultTitle'] ?? '',
      type: defaultValues['defaultType'] ?? '',
      report: json['report'] ?? defaultValues['defaultReport'] ?? '',
      purpose: defaultValues['defaultPurpose'] ?? '',
      loanApplication: json['loanApplication'] ?? defaultValues['defaultLoanApplication'] ?? '',
      date: defaultValues['defaultDate'] ?? '',
      dateTime: defaultValues['defaultDateTime'] != null ? DateTime.parse(defaultValues['defaultDateTime']) : DateTime.now(),
      icon: defaultValues['defaultIcon'] ?? 'assets/bank_logos/default_logo.svg',
      affect: defaultValues['defaultAffect'] ?? '',
      important: defaultValues['important'] ?? '',
      notImportant: defaultValues['notImportant'] ?? '',
      isImportant: json['isImportant'] ?? previousIsImportant ?? defaultValues['defaultIsImportant'],
      search: defaultValues['search'] ?? '',
      queries: defaultValues['queries'] ?? '',
    );
  }

}

class DataProvider with ChangeNotifier {
  List<CardItem> _items = [];
  List<CardItem> _filteredItems = [];

  List<CardItem> get items => _filteredItems;

  Future<void> loadItems(bool isArmenian) async {
    String language = isArmenian ? 'arm' : 'en';
    String predefinedFileName = isArmenian ? 'predefinedarm.json' : 'predefineden.json';

    String predefinedContent = await rootBundle.loadString('assets/$predefinedFileName');
    List<dynamic> itemsJson = json.decode(predefinedContent)['items'];

    List<Future<String>> defaultFileContents = itemsJson.map((item) async {
      String defaultContent = await rootBundle.loadString('assets/$language.json');
      return defaultContent;
    }).toList();

    List<String> defaultContents = await Future.wait(defaultFileContents);

    _items = List.generate(itemsJson.length, (index) {
      Map<String, dynamic> item = itemsJson[index];
      Map<String, dynamic> defaultValues = json.decode(defaultContents[index])['items'][0];
      return CardItem.fromJson(item, defaultValues, _items.isNotEmpty ? _items[index].isImportant : defaultValues['defaultIsImportant']);
    });

    _filteredItems = _items;
    notifyListeners();
  }




  void filterList(String query) {
    _filteredItems = _items.where((item) {
      final titleLower = item.title.toLowerCase();
      return titleLower.contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }
}
