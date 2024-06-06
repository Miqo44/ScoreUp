import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../card_item.dart';
import 'list_view.dart';
import 'login.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  bool isArmenian = true;

  void _toggleLanguage() {
    setState(() {
      isArmenian = !isArmenian;
      Provider.of<DataProvider>(context, listen: false).loadItems(isArmenian);
    });
  }

  void _loginSuccess() {
    setState(() {
      isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.loadItems(isArmenian);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Mardoto',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: isLoggedIn
          ? MyHomePage(isArmenian: isArmenian, toggleLanguage: _toggleLanguage)
          : LoginPage(onLoginSuccess: _loginSuccess),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final bool isArmenian;
  final VoidCallback toggleLanguage;

  const MyHomePage({
    super.key,
    required this.isArmenian,
    required this.toggleLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final cardItem = dataProvider.items.isNotEmpty ? dataProvider.items.first : null;
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor: Colors.blue,
        toolbarHeight: 120,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  cardItem != null ? cardItem.queries : '',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SearchField(isArmenian: isArmenian, cardItem: cardItem,),
          ],
        ),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 30, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  isArmenian ? Icons.language : Icons.translate,
                  size: 24,
                  color: Colors.white,
                ),
                onPressed: toggleLanguage,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: MyListView(isArmenian: isArmenian),
    );
  }
}

class SearchField extends StatelessWidget {
  final bool isArmenian;
  final CardItem? cardItem;

  const SearchField({
    super.key,
    required this.isArmenian,
    required this.cardItem,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: cardItem != null ? cardItem!.search : '',
        prefixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      ),
      onChanged: (query) {
        Provider.of<DataProvider>(context, listen: false).filterList(query);
      },
    );
  }
}