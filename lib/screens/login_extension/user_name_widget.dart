import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:packages/colors.dart';

class UserNameWidget extends StatefulWidget {
  const UserNameWidget({
    super.key,
    required this.usernameController,
    required this.usernameFocusNode,
    required this.usernameFieldColor,
    required this.usernameError,
  });

  final TextEditingController usernameController;
  final FocusNode usernameFocusNode;
  final Color usernameFieldColor;
  final String? usernameError;

  @override
  UserNameWidgetState createState() => UserNameWidgetState();
}

class UserNameWidgetState extends State<UserNameWidget> {
  @override
  void initState() {
    super.initState();
    widget.usernameController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            TextField(
              controller: widget.usernameController,
              focusNode: widget.usernameFocusNode,
              decoration: InputDecoration(
                filled: true,
                fillColor: widget.usernameFieldColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: widget.usernameError != null
                        ? AppColors.errorBorderColor
                        : Colors.transparent,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: widget.usernameError != null
                        ? AppColors.errorBorderColor
                        : AppColors.focusedBorderColor,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: widget.usernameError != null
                        ? AppColors.errorBorderColor
                        : AppColors.usernameFieldColorError,
                    width: 1.0,
                  ),
                ),
                contentPadding: const EdgeInsets.only(left: 60),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
                FilteringTextInputFormatter.allow(
                  RegExp(r'^[0-9]*$'),
                ),
              ],
              style: const TextStyle(
                color: Colors.transparent,
                decorationColor: Colors.black,
                decoration: TextDecoration.none,
              ),
              cursorColor: Colors.black,
            ),
            const Positioned(
              left: 16,
              child: IgnorePointer(
                child: Text(
                  '+374',
                  style: TextStyle(
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 60,
              top: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.usernameController.text.padRight(11, '•'),
                    style: const TextStyle(
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (widget.usernameError != null)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Text(
              widget.usernameError!,
              style: const TextStyle(
                fontSize: 12,
                height: 1.3,
                color: AppColors.errorBorderColor,
              ),
            ),
          ),
      ],
    );
  }
}
