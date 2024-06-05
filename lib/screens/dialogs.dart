import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DialogUtils {
  static void showIncorrectAttemptsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        actionsPadding:
        const EdgeInsets.symmetric(vertical: 11, horizontal: 0.5),
        icon: SvgPicture.asset('assets/48 Warning.svg'),
        title: const Text(
          'Ուշադրություն',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Ձեր տվյալները մուտք են արվել \nթույլատրելի քանակից շատ։',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color.fromRGBO(31, 121, 255, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showErrorDialog(BuildContext context, String message) {
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
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
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(31, 121, 255, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
