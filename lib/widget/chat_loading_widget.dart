import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatLoadingWidget extends StatelessWidget {
  const ChatLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        SizedBox(width: 15),
        SpinKitRotatingCircle(color: Colors.blue, size: 20.0),
        SpinKitRotatingPlain(color: Colors.amber, size: 20.0),
        SpinKitSquareCircle(color: Colors.blue, size: 20.0),
        SizedBox(width: 15),
      ],
    );
  }
}
