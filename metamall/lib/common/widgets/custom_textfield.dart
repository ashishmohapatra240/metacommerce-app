import 'package:flutter/material.dart';
import 'package:metamall/constants/global_variables.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText),
        SizedBox(height: 8,),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            focusColor: GlobalVariables.secondaryColor,
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: GlobalVariables.secondaryColor)),
            disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: GlobalVariables.secondaryColor)),
            hintText: 'Enter your $hintText',
            hintStyle: const TextStyle(
              color: Color.fromRGBO(117, 117, 117, 1),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: GlobalVariables.secondaryColor,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: Color.fromRGBO(83, 83, 83, 1),
              ),
            ),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Enter your $hintText';
            }
            return null;
          },
          maxLines: maxLines,
        ),
      ],
    );
  }
}
