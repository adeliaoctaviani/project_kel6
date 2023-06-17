import 'package:flutter/material.dart';

class ObfuscatingText extends StatefulWidget {
  final String text;

  const ObfuscatingText(this.text);

  @override
  _ObfuscatingTextState createState() => _ObfuscatingTextState();
}

class _ObfuscatingTextState extends State<ObfuscatingText> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          obscure = !obscure;
        });
      },
      child: Text(
        obscure ? '********' : widget.text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: obscure ? Colors.grey : Colors.black,
        ),
      ),
    );
  }
}
