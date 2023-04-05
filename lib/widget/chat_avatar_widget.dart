import 'package:flutter/material.dart';

class ChatAvatarWidget extends StatelessWidget {
  final String imageUrl;
  final String fallbackText;

  const ChatAvatarWidget({
    Key? key,
    required this.imageUrl,
    required this.fallbackText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: 40,
        height: 40,
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _fallbackWidget();
                },
              )
            : _fallbackWidget(),
      ),
    );
  }

  Widget _fallbackWidget() {
    return Container(
      width: 40,
      height: 40,
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: Text(
        fallbackText.substring(0, 1).toUpperCase(),
        style: const TextStyle(
          fontSize: 20, // Adjust the font size according to your needs
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
