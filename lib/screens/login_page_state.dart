import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harcum1/screens/registration/registration.dart';
import 'login.dart';
import 'login_extension/login_request.dart';
import 'login_extension/user_name_widget.dart';
import 'login_extension/login_dialogs.dart';
import 'menu.dart';
import 'package:packages/colors.dart';

class LoginPageState extends State<LoginPage> {
  final DioService dioService = DioService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor: AppColors.appBarBackground,
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
                  Text(
                    'Հեռախոսահամար',
                    style: TextStyle(fontWeight: FontWeight.bold, height: 1.17),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              UserNameWidget(
                  usernameController: _usernameController,
                  usernameFocusNode: _usernameFocusNode,
                  usernameFieldColor: _usernameFieldColor,
                  usernameError: _usernameError),
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
                          height: 1.3, color: AppColors.linkText, fontSize: 12),
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
                  hintStyle: const TextStyle(height: 1.17),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: _passwordError != null
                          ? AppColors.errorBorderColor
                          : Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: _passwordError != null
                          ? AppColors.errorBorderColor
                          : AppColors.focusedBorderColor,
                      width: 1.0,
                    ),
                  ),
                  errorText: _passwordError,
                  errorStyle: const TextStyle(
                    height: 1.3,
                    color: AppColors.errorText,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: _passwordError != null
                          ? AppColors.errorBorderColor
                          : AppColors.passwordFieldColorDefault,
                      width: 1.0,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.passwordVisibilityIcon,
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
                            AppColors.buttonBackground,
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
                              builder: (context) => const Registration(),
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

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  String? _usernameError;
  String? _passwordError;
  Color _usernameFieldColor = AppColors.usernameFieldColorDefault;
  Color _passwordFieldColor = AppColors.passwordFieldColorDefault;

  @override
  void initState() {
    super.initState();
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

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _validateUserName() {
    setState(() {
      _usernameError =
      _usernameController.text.length < 8 ? 'Նվազագույնը 8 թիվ' : null;
      _usernameFieldColor = _usernameError != null
          ? AppColors.usernameFieldColorError
          : AppColors.usernameFieldColorDefault;
    });
  }

  void _validatePassword() {
    setState(() {
      _passwordError =
      _passwordController.text.length < 8 ? 'Նվազագույնը 8 նիշ' : null;
      _passwordFieldColor = _passwordError != null
          ? AppColors.passwordFieldColorError
          : AppColors.passwordFieldColorDefault;
    });
  }

  void _validateUsernameLength() {
    setState(() {
      _usernameFieldColor =
      _usernameController.text.isNotEmpty && _usernameError == null
          ? AppColors.usernameFieldColorDefault
          : (_usernameController.text.length >= 8
          ? AppColors.usernameFieldColorDefault
          : AppColors.usernameFieldColorError);
    });
  }

  void _validatePasswordLength() {
    setState(() {
      _passwordFieldColor =
      _passwordController.text.isNotEmpty && _passwordError == null
          ? AppColors.passwordFieldColorDefault
          : (_passwordController.text.length >= 8
          ? AppColors.passwordFieldColorDefault
          : AppColors.passwordFieldColorError);
    });
  }

  void _onUsernameFocusChange() {
    if (!_usernameFocusNode.hasFocus) {
      _validateUserName();
      _validateUsernameLength();
    } else {
      _usernameFieldColor = _usernameError != null
          ? AppColors.usernameFieldColorError
          : AppColors.usernameFieldColorDefault;
    }
  }

  void _onPasswordFocusChange() {
    if (!_passwordFocusNode.hasFocus) {
      _validatePassword();
      _validatePasswordLength();
    } else {
      _passwordFieldColor = _passwordError != null
          ? AppColors.passwordFieldColorError
          : AppColors.passwordFieldColorDefault;
    }
  }

  int _incorrectAttempts = 0;
  bool _loginButtonEnabled = true;

  Future<void> _login() async {
    _validateUserName();
    _validatePassword();

    if (_usernameError == null && _passwordError == null) {
      try {
        await dioService.login(_usernameController.text, _passwordController.text);
        widget.onLoginSuccess();
      } catch (e) {
        _incorrectAttempts++;
        if (_incorrectAttempts >= 3) {
          _showIncorrectAttemptsDialog();
          _disableLoginButton();
        } else {
          _showErrorDialog('Մուտքային տվյալները սխալ են լրացված։');
        }
      }
    }
  }

  void _showIncorrectAttemptsDialog() {
    DialogUtils.showIncorrectAttemptsDialog(context);
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
    DialogUtils.showErrorDialog(context, message);
  }
}