import 'package:flutter/material.dart';

class CustomChipButton extends StatelessWidget {
  final Function onTapFunction;
  final Color backgroundColor;
  final Color labelAndIconColor;
  final String label;
  final Icon icon;

  CustomChipButton({
    @required this.onTapFunction,
    this.backgroundColor,
    this.labelAndIconColor = Colors.black,
    this.label = 'Salvar',
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
      child: Chip(
        labelPadding:
            const EdgeInsets.only(left: 10, right: 4, top: 2, bottom: 2),
        padding: const EdgeInsets.all(10),
        backgroundColor: backgroundColor == null
            ? Theme.of(context).accentColor
            : backgroundColor,
        label: Text(
          label,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: labelAndIconColor),
        ),
        avatar:
            icon == null ? Icon(Icons.save, color: labelAndIconColor) : icon,
      ),
    );
  }
}
