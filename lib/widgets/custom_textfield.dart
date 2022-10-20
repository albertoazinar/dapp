import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String? validatorText, hintText, label;
  void Function(String value)? onChange;
  bool? isPasswordField, isOptional, validator;
  TextInputType? inputType;
  TextEditingController? controller;

  CustomTextField(
      {this.validatorText,
      required this.hintText,
      required this.onChange,
      this.isPasswordField = false,
      this.isOptional = true,
      this.inputType,
      this.controller,
      this.validator = false,
      this.label});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 10, left: 12, right: 12),
            child: RichText(
                text: TextSpan(
              text: widget.label ?? '',
              style: TextStyle(color: Colors.blueGrey),
              children: [
                TextSpan(
                  text: widget.isOptional! ? '' : '*',
                ),
              ],
            ))),
        Container(
          margin: EdgeInsets.only(bottom: 20, left: 12, right: 12),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            obscureText: widget.isPasswordField! ? isObscureText : false,
            validator: widget.validator!
                ? (val) {
                    return widget.validatorText;
                  }
                : (val) {
                    return val!.isEmpty
                        ? widget.validatorText != null
                            ? widget.validatorText!
                            : null
                        : null;
                  },
            keyboardType: widget.inputType,
            style: TextStyle(color: Colors.blueGrey),
            controller: widget.controller,
            decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIcon: widget.isPasswordField!
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                        },
                        child: Icon(isObscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )
                    : SizedBox(),
                hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 17)),
            cursorColor: Colors.blueGrey,
            onChanged: widget.onChange,
          ),
        ),
      ],
    );
  }
}
