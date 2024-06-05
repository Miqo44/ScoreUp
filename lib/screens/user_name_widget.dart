import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({
    super.key,
    required TextEditingController usernameController,
    required FocusNode usernameFocusNode,
    required Color usernameFieldColor,
    required String? usernameError,
  }) : _usernameController = usernameController, _usernameFocusNode = usernameFocusNode, _usernameFieldColor = usernameFieldColor, _usernameError = usernameError;

  final TextEditingController _usernameController;
  final FocusNode _usernameFocusNode;
  final Color _usernameFieldColor;
  final String? _usernameError;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _usernameController,
      focusNode: _usernameFocusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: _usernameFieldColor,
        hintText: '+374 1• ••• •••',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: _usernameError != null ? const Color.fromARGB(255, 255, 104, 109) : Colors.transparent,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: _usernameError != null ? const Color.fromARGB(255, 255, 104, 109) : const Color.fromRGBO(16, 112, 255, 1),
            width: 1.0,
          ),
        ),
        errorText: _usernameError,
        errorStyle: const TextStyle(
          height: 1.3,
          color: Color.fromARGB(255, 255, 104, 109),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: _usernameError != null ? const Color.fromARGB(255, 255, 104, 109) : const Color.fromRGBO(240, 244, 255, 1),
            width: 1.0,
          ),
        ),
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^[0-9+]*$'),
        ),
      ],
    );
  }
}