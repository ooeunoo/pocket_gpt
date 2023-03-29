import 'package:flutter/material.dart';

class ChatCatergoryChipWidget extends StatefulWidget {
  final String categoryName;
  final Function(bool) onSelected;
  final bool isSelected;

  const ChatCatergoryChipWidget({
    super.key,
    required this.categoryName,
    required this.onSelected,
    required this.isSelected,
  });

  @override
  State<ChatCatergoryChipWidget> createState() =>
      _ChatCatergoryChipWidgetState();
}

class _ChatCatergoryChipWidgetState extends State<ChatCatergoryChipWidget> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        widget.categoryName,
        style: TextStyle(
            color: widget.isSelected ? Colors.white : Colors.grey,
            fontSize: 12),
      ),
      selected: widget.isSelected,
      onSelected: widget.onSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      backgroundColor: Colors.white,
      selectedColor: Colors.blue,
      showCheckmark: false,
    );
  }
}
