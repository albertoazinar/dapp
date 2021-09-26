import 'package:flutter/material.dart';

class CustomRadioGroup extends StatefulWidget {
  double width;
  String label;
  List<Widget> radioItems;

  CustomRadioGroup(
      {Key key,
      @required this.width,
      @required this.label,
      @required this.radioItems})
      : super(key: key);

  @override
  _CustomRadioGroupState createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.width / 3,
            padding: const EdgeInsets.only(left: 20, top: 12, bottom: 0),
            child: Text(widget.label),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.radioItems,
          ),
        ],
      ),
    );
  }
}
