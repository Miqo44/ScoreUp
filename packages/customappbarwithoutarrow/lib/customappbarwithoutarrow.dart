import 'package:flutter/material.dart';

class CustomAppBarWithoutArrow extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double toolBarHeight;

  const CustomAppBarWithoutArrow({super.key, required this.title, required this.toolBarHeight});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: const TextStyle(color: Colors.white),),
      automaticallyImplyLeading: false,
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