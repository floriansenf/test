import 'package:flutter/material.dart';
import 'package:login/components/text_field_container.dart';
import 'package:login/constants.dart';
class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
 final TextEditingController controller;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon=Icons.person,
    this.onChanged,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
          controller: controller,
          validator: (value){
            if(value==null || value.isEmpty){
              return "Geben Sie etwas in das Feld ein";
            }
            return null;
          },
          decoration: InputDecoration(
            icon:Icon( icon,
              color: kPrimaryColor,),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),);
  }
}