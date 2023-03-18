import 'package:flutter/material.dart';
import 'package:tricycle/components/delegatedText.dart';
import '../utils/constant.dart';

class delegatedForm extends StatefulWidget {
  final String fieldName;
  final IconData icon;
  final IconData? editIcon;
  final String hintText;
  final TextEditingController? formController;
  final String? Function(String?)? validator;

  const delegatedForm({
    required this.fieldName,
    required this.icon,
    required this.hintText,
    this.formController,
    this.editIcon,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  State<delegatedForm> createState() => _delegatedFormState();
}

String? _errorText;
bool? enabled = false;

class _delegatedFormState extends State<delegatedForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              Icon(widget.icon),
              const SizedBox(width: 15),
              DelegatedText(
                text: widget.fieldName,
                fontSize: 15,
                fontName: 'InterMed',
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    enabled = !enabled!;
                  });
                },
                icon: Icon(widget.editIcon, size: 30),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: TextFormField(
            enabled: (widget.editIcon != null) ? enabled : !enabled!,
            validator: widget.validator,
            controller: widget.formController,
            style: const TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              errorText: _errorText,
              filled: true,
              hintText: widget.hintText,
              border: const UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Constants.primaryColor,
                ),
              ),
              // fillColor: Constants.tertiaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
