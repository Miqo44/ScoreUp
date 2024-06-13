import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double toolBarHeight;

  const CustomAppBar({super.key, required this.title, required this.toolBarHeight});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: const TextStyle(color: Colors.white),),
      leading: IconButton(color: Colors.white,
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop(),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      backgroundColor: const Color(0xFF1070FF),
      centerTitle: true,
      toolbarHeight: toolBarHeight,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight);
}