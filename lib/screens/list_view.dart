import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../card_item.dart';
import '../card_item_widget.dart';

class MyListView extends StatelessWidget {
  final bool isArmenian;

  const MyListView({super.key, required this.isArmenian});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        final items = dataProvider.items;
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CardItemWidget(item: item);
          },
        );
      },
    );
  }
}
