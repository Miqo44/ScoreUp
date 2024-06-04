import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harcum1/screens/menu.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginPage({super.key, required this.onLoginSuccess});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  String? _registeredUsername;
  String? _registeredPassword;
  String? _usernameError;
  String? _passwordError;
  Color _usernameFieldColor = const Color.fromRGBO(240, 244, 255, 1);
  Color _passwordFieldColor = const Color.fromRGBO(240, 244, 255, 1);

  @override
  void initState() {
    super.initState();
    _loadCredentials();
    _usernameController.addListener(_validateUsernameLength);
    _passwordController.addListener(_validatePasswordLength);
    _usernameFocusNode.addListener(_onUsernameFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
  }

  @override
  void dispose() {
    _usernameController.removeListener(_validateUsernameLength);
    _passwordController.removeListener(_validatePasswordLength);
    _usernameFocusNode.removeListener(_onUsernameFocusChange);
    _passwordFocusNode.removeListener(_onPasswordFocusChange);
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadCredentials() async {
    String credentialsContent =
        await rootBundle.loadString('assets/credentials.json');
    Map<String, dynamic> credentials = json.decode(credentialsContent);
    setState(() {
      _registeredUsername = credentials['username'];
      _registeredPassword = credentials['password'];
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _validateUsername() {
    setState(() {
      _usernameError =
          _usernameController.text.length < 8 ? 'Նվազագույնը 8 թիվ' : null;
      _usernameFieldColor = _usernameError != null
          ? const Color.fromARGB(255, 255, 243, 243)
          : const Color.fromRGBO(240, 244, 255, 1);
    });
  }

  void _validatePassword() {
    setState(() {
      _passwordError =
          _passwordController.text.length < 8 ? 'Նվազագույնը 8 նիշ' : null;
      _passwordFieldColor = _passwordError != null
          ? const Color.fromARGB(255, 255, 243, 243)
          : const Color.fromRGBO(240, 244, 255, 1);
    });
  }

  void _validateUsernameLength() {
    setState(() {
      _usernameFieldColor =
          _usernameController.text.isNotEmpty && _usernameError == null
              ? const Color.fromRGBO(240, 244, 255, 1)
              : (_usernameController.text.length >= 8
                  ? const Color.fromRGBO(240, 244, 255, 1)
                  : const Color.fromARGB(255, 255, 243, 243));
    });
  }

  void _validatePasswordLength() {
    setState(() {
      _passwordFieldColor =
          _passwordController.text.isNotEmpty && _passwordError == null
              ? const Color.fromRGBO(240, 244, 255, 1)
              : (_passwordController.text.length >= 8
                  ? const Color.fromRGBO(240, 244, 255, 1)
                  : const Color.fromARGB(255, 255, 243, 243));
    });
  }

  void _onUsernameFocusChange() {
    if (!_usernameFocusNode.hasFocus) {
      _validateUsername();
      _validateUsernameLength();
    } else {
      _usernameFieldColor = _usernameError != null
          ? const Color.fromARGB(255, 255, 243, 243)
          : const Color.fromRGBO(240, 244, 255, 1);
    }
  }

  void _onPasswordFocusChange() {
    if (!_passwordFocusNode.hasFocus) {
      _validatePassword();
      _validatePasswordLength();
    } else {
      _passwordFieldColor = _passwordError != null
          ? const Color.fromARGB(255, 255, 243, 243)
          : const Color.fromRGBO(240, 244, 255, 1);
    }
  }

  int _incorrectAttempts = 0;
  bool _loginButtonEnabled = true;

  void _login() {
    _validateUsername();
    _validatePassword();

    if (_usernameError == null && _passwordError == null) {
      if (_registeredUsername != null && _registeredPassword != null) {
        if (_usernameController.text == _registeredUsername &&
            _passwordController.text == _registeredPassword) {
          widget.onLoginSuccess();
        } else {
          _incorrectAttempts++;
          if (_incorrectAttempts >= 3) {
            _showIncorrectAttemptsDialog();
            _disableLoginButton();
          } else {
            _showErrorDialog('Մուտքային տվյալները սխալ են լրացված։');
          }
        }
      } else {
        _showErrorDialog('');
      }
    }
  }

  void _showIncorrectAttemptsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        actionsPadding:
            const EdgeInsets.symmetric(vertical: 11, horizontal: 0.5),
        icon: SvgPicture.asset('assets/48 Warning.svg'),
        title: const Text('Ուշադրություն',style: TextStyle(fontWeight: FontWeight.bold),),
        content: const Text(
          'Ձեր տվյալները մուտք են արվել \nթույլատրելի քանակից շատ։',
          textAlign: TextAlign.center,style: TextStyle(fontSize: 14),
        ),
        actions: [
          const Divider(
            height: 0.5,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Center(
              child: Text(
                'Վերականգնել գաղտնաբառը',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,
                  color: Color.fromRGBO(31, 121, 255, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _disableLoginButton() {
    setState(() {
      _loginButtonEnabled = false;
    });
    Future.delayed(const Duration(seconds: 30), () {
      setState(() {
        _loginButtonEnabled = true;
      });
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        actionsPadding:
            const EdgeInsets.symmetric(vertical: 11, horizontal: 0.5),
        title: const Center(
          child: Text(
            'Սխալ մուտքային տվյալներ',
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          ),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,style: const TextStyle(fontSize: 14),
        ),
        actions: [
          const Divider(
            height: 0.5,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Փորձել կրկին',
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(31, 121, 255, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor: const Color(0xFF1070FF),
        title: const Text(
          'Մուտք',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 43,
              ),
              SvgPicture.asset('assets/undraw_access_account_re_8spm 1.svg'),
              const SizedBox(
                height: 35,
              ),
              const Row(
                children: [
                  Text('Հեռախոսահամար',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              TextField(
                controller: _usernameController,
                focusNode: _usernameFocusNode,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _usernameFieldColor,
                  hintText: '+374 1• ••• •••',
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(16, 112, 255, 1),
                      width: 1.0,
                    ),
                  ),
                  errorText: _usernameError,
                  errorStyle: const TextStyle(
                    color: Color.fromARGB(255, 255, 104, 109),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9+]*$'),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Text('Գաղտնաբառ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  RichText(
                    text: TextSpan(
                      text: 'Մոռացե՞լ եք գաղտնաբառը',
                      style: const TextStyle(
                          color: Color(0xFF70A9FF), fontSize: 12),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyApp(),
                            ),
                          );
                        },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              TextField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _passwordFieldColor,
                  hintText: 'Գաղտնաբառ',
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(16, 112, 255, 1),
                      width: 1.0,
                    ),
                  ),
                  errorText: _passwordError,
                  errorStyle: const TextStyle(
                    color: Color.fromARGB(255, 255, 104, 109),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: _obscureText,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: TextButton(
                        onPressed: _loginButtonEnabled ? _login : null,
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            const Color(0xFF70A9FF),
                          ),
                        ),
                        child: const Text(
                          'Մուտք',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: 'Դեռ չե՞ք գրանցվել։ ',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Գրանցվել',
                      style: const TextStyle(
                          color: Color(0xFF70A9FF), fontSize: 14),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyApp(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
