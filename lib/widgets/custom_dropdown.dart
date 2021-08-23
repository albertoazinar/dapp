import 'package:flutter/material.dart';

class CustomDropDownTextField extends StatefulWidget {
  Map<String, dynamic> items;
  dynamic currentSelectedValue;
  String label;
  double width;
  var validacao, onChange, widthFactor, fontSize;
  Key textKey;

  CustomDropDownTextField(
      {Key key,
      @required this.items,
      @required this.currentSelectedValue,
      this.label,
      @required this.width,
      this.validacao,
      this.onChange,
      this.widthFactor,
      this.fontSize,
      this.textKey})
      : super(key: key);
  @override
  _CustomDropDownTextFieldState createState() =>
      _CustomDropDownTextFieldState();
}

class _CustomDropDownTextFieldState extends State<CustomDropDownTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? SizedBox()
            : Container(
                width: widget.width / 1.2,
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: Text(widget.label),
              ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Container(
            child: DropdownButtonFormField<dynamic>(
              decoration: InputDecoration(
                fillColor: Colors.blueGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: widget.currentSelectedValue,
              isDense: true,
              onChanged: widget.onChange,
              items: widget.items
                  .map((String handler, dynamic value) {
                    return MapEntry(
                      handler,
                      DropdownMenuItem<String>(
                        value: handler,
                        child: new Text(
                          handler,
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    );
                  })
                  .values
                  .toList(),
              validator: widget.validacao,
            ),
          ),
        ),
      ],
    );
  }
}
