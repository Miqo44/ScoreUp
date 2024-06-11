import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packages/colors.dart';

import 'confirmation.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 88,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor: AppColors.appBarBackground,
        title: const Text(
          'Գրանցում',
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
              SizedBox(height: 9,
                child: LinearProgressIndicator(
                  value: 0.2,
                  color: AppColors.linearIndicatorColor,
                  borderRadius: BorderRadius.circular(10),
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor:AppColors.usernameFieldColorDefault,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9)
                  )
                ),
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
