import 'package:flutter/material.dart';

class TextRichWidget extends StatelessWidget {
  const TextRichWidget({
    super.key,
    this.onTap,
    required this.textTitle,
    required this.subTitle,
  });
  final void Function()? onTap;
  final String textTitle;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: onTap,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: textTitle),
              TextSpan(
                text: subTitle,
                style: TextStyle(
                  color: Color(0xff5F33E1),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          style: TextStyle(
            fontSize: 13,
            color: Color(0xff6E6A7C),
          ),
        ),
      ),
    );
  }
}
