import 'package:flutter/material.dart';

class StyledType extends StatelessWidget {
  const StyledType({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color(0xFFBBE0CF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Center(child: Text(type)),
      ),
    );
  }
}
