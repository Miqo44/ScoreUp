import 'package:flutter/material.dart';
import 'login_page_state.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginPage({super.key, required this.onLoginSuccess});

  @override
  LoginPageState createState() => LoginPageState();
}

