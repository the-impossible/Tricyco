import 'package:flutter/material.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/utils/constant.dart';

class DelegatedButton extends StatelessWidget {
  final Future<dynamic>? onClicked;
  final String text;

  const DelegatedButton({
    required this.onClicked,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onClicked;
      },
      style: ElevatedButton.styleFrom(
        primary: Constants.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: DelegatedText(
        fontSize: 20,
        text: text,
        color: Constants.secondaryColor,
      ),
    );
  }
}
