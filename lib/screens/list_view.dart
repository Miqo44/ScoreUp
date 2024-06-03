import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../card_item.dart';

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
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          item.icon,
                          width: 32.0,
                          height: 32.0,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      item.type,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      item.report,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      item.purpose,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      item.loanApplication,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      item.date,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      DateFormat('dd.MM.yyyy').format(item.dateTime),
                      style: const TextStyle(),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      item.affect,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        SvgPicture.asset(
                          item.isImportant
                              ? 'assets/affects/low_price.svg'
                              : 'assets/affects/Group.svg',
                          width: 20.0,
                          height: 20.0,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          item.isImportant ? item.important : item.notImportant,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
