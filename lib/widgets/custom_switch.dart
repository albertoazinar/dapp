import 'package:despensa/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatefulWidget {
  late double width;
  late String label;
  late bool val;
  late var onToggle;
  late bool isRow = false;

  CustomSwitch(
      {Key? key,
      required this.width,
      required this.label,
      required this.val,
      this.onToggle,
      this.isRow = false})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      valueFontSize: 13.0,
      activeText: 'Dark',
      height: 28,
      width: 62,
      toggleSize: 20,
      inactiveText: 'Light',
      activeColor: shadesOfGrey[2],
      value: widget.val,
      showOnOff: true,
      onToggle: widget.onToggle,
    );
  }
}
