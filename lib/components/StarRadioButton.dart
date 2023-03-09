import 'package:flutter/material.dart';

class StarRadioButton extends StatefulWidget {
  final bool isSelected;
  final ValueChanged<bool> onSelect;

  const StarRadioButton(
      {Key? key, required this.isSelected, required this.onSelect})
      : super(key: key);

  @override
  _StarRadioButtonState createState() => _StarRadioButtonState();
}

class _StarRadioButtonState extends State<StarRadioButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelect(!widget.isSelected);
      },
      child: Stack(
        children: [
          Icon(
            Icons.star,
            color: widget.isSelected ? Colors.teal : Colors.grey,
            size: 50.0,
          ),
          const Icon(
            Icons.star_border,
            color: Colors.teal,
            size: 50.0,
          ),
        ],
      ),
    );
  }
}
