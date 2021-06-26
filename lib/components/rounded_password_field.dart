import 'package:flutter/material.dart';
import 'package:login/components/text_field_container.dart';
import 'package:login/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final TextEditingController controller;

  const RoundedPasswordField({Key key, this.controller}) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(

        child: TextFormField(
      obscureText: _isHidden,
      controller: widget.controller,
      validator: (value){
        if(value==null || value.isEmpty){
          return "Geben Sie etwas in das Feld ein";
        }
        return null;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Passwort",
        contentPadding: EdgeInsets.only(top: 15),
        icon: Icon(
          Icons.lock,
          color: kPrimaryColor,
        ),
        suffixIcon: InkWell(
          onTap: _togglePasswordView,
          child: Icon(
            _isHidden ? Icons.visibility : Icons.visibility_off,
            color: kPrimaryColor,
          ),
        ),
      ),
    ));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
