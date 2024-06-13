import 'package:customappbarwithoutarrow/customappbarwithoutarrow.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packages/colors.dart';
import '../login_extension/login_request.dart';
import 'confirmation.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  RegistrationState createState() => RegistrationState();
}

class RegistrationState extends State<Registration> {
  final TextEditingController _registrationUsernameController =
      TextEditingController();
  final FocusNode _registrationUsernameFocusNode = FocusNode();
  Color _registrationUsernameFieldColor = AppColors.usernameFieldColorDefault;
  String? _registrationUsernameError;
  final DioService _dioService = DioService();

  @override
  void initState() {
    super.initState();
    _registrationUsernameFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _registrationUsernameController.dispose();
    _registrationUsernameFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_registrationUsernameFocusNode.hasFocus) {
      setState(() {
        if (_registrationUsernameController.text.length < 8) {
          _registrationUsernameError = 'Նվազագույնը 8 թիվ';
          _registrationUsernameFieldColor = AppColors.usernameFieldColorError;
        } else {
          _registrationUsernameError = null;
          _registrationUsernameFieldColor = AppColors.usernameFieldColorDefault;
        }
      });
    }
  }

  Future<void> _onSubmit() async {
    try {
      final phoneNumber = _registrationUsernameController.text;
      await _dioService.checkPhoneNumber(phoneNumber, (bool exists) {
        if (exists) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PhoneNumberConfirmation(),
            ),
          );
        } else {
          setState(() {
            _registrationUsernameError =
                'Նշված հեռախոսահամարով հաշիվ գրանցված է';
            _registrationUsernameFieldColor = AppColors.usernameFieldColorError;
          });
        }
      });
    } catch (e) {
      setState(() {
        _registrationUsernameError = 'Նշված հեռախոսահամարով հաշիվ գրանցված է';
        _registrationUsernameFieldColor = AppColors.usernameFieldColorError;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWithoutArrow(title: 'Գրանցում', toolBarHeight: 96,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 9,
                child: LinearProgressIndicator(
                  value: 0.023,
                  color: AppColors.linearIndicatorColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const Row(
                children: [
                  Text('0%'),
                ],
              ),
              const SizedBox(
                height: 55,
              ),
              Center(
                child: SvgPicture.asset(
                    'assets/undraw_mobile_encryption_re_yw3o (1) 1.svg'),
              ),
              const SizedBox(
                height: 55,
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
              TextField(
                controller: _registrationUsernameController,
                focusNode: _registrationUsernameFocusNode,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _registrationUsernameFieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: _registrationUsernameError != null
                          ? AppColors.errorBorderColor
                          : Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: _registrationUsernameError != null
                          ? AppColors.errorBorderColor
                          : AppColors.focusedBorderColor,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: _registrationUsernameError != null
                          ? AppColors.errorBorderColor
                          : AppColors.usernameFieldColorError,
                      width: 1.0,
                    ),
                  ),
                  errorText: _registrationUsernameError,
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9]*$'),
                  ),
                ],
                style: const TextStyle(
                  color: Colors.black,
                  decorationColor: Colors.black,
                  decoration: TextDecoration.none,
                ),
                cursorColor: Colors.black,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: TextButton(
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PhoneNumberConfirmation(),
                            ),
                          );
                        },
                        // onPressed: _onSubmit,
                        child: const Text(
                          'Ստանալ հաստատման կոդը',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: 'Արդեն գրանցվա՞ծ եք։ ',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Մուտք',
                      style: const TextStyle(
                          color: Color(0xFF70A9FF), fontSize: 14),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
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
