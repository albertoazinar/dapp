import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  String val, groupVal, valueLabel;
  var onChange;
  double width;

  CustomRadio(
      {@required this.width,
      @required this.val,
      @required this.groupVal,
      @required this.valueLabel,
      this.onChange});

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width / 4.3,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
        title: Align(
            alignment: Alignment(-5.8, 0), child: Text(widget.valueLabel)),
        leading: Container(
          child: Radio(
            value: widget.val,
            groupValue: widget.groupVal,
            onChanged: widget.onChange,
          ),
        ),
      ),
    );
  }
}
