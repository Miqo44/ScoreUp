import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:packages/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneNumberConfirmation extends StatefulWidget {
  const PhoneNumberConfirmation({super.key});

  @override
  State<PhoneNumberConfirmation> createState() =>
      _PhoneNumberConfirmationState();
}

class _PhoneNumberConfirmationState extends State<PhoneNumberConfirmation> {
  Timer? _timer;
  int _start = 60;

  void startTimer() {
    _start = 60;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startTimer();
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 96,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor: AppColors.appBarBackground,
        title: const Text(
          'Հաստատում',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
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
                height: 36,
              ),
              Center(
                child: SvgPicture.asset(
                    'assets/undraw_modern_design_re_dlp8 1.svg'),
              ),
              const SizedBox(
                height: 36,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Խնդրում ենք մուտքագրել Ձեզ \nուղարկված կոդը',
                    style: TextStyle(fontWeight: FontWeight.bold, height: 1.17),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 52,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onChanged: (value) {},
                  onCompleted: (value) {},
                  keyboardType: TextInputType.number,
                  enableActiveFill: true,
                  textStyle: const TextStyle(fontSize: 18),
                  showCursor: true,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 52,
                    fieldWidth: 52,
                    activeColor: AppColors.usernameFieldColorDefault,
                    activeFillColor: AppColors.usernameFieldColorDefault,
                    selectedFillColor: Colors.transparent,
                    inactiveFillColor: AppColors.usernameFieldColorError,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(right: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      formatTime(_start),
                      style: const TextStyle(
                          fontSize: 14, color: AppColors.focusedBorderColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Մենք ուղարկել ենք հաստատման կոդը\n+374 ** *** *** հեռախոսահամարին։ Գտեք այն Ձեր\nհաղորդագրություններում։',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 21,
              ),
              TextButton(
                onPressed: () {
                  startTimer();
                },
                child: const Text(
                  "Ուղարկել նորից",
                  style: TextStyle(color: AppColors.focusedBorderColor),
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
