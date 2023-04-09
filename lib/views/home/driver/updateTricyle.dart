import 'package:flutter/material.dart';
import 'package:tricycle/components/delegatedForm.dart';
import 'package:tricycle/components/delegatedText.dart';
import 'package:tricycle/utils/constant.dart';

class UpdateTricycleForm extends StatefulWidget {
  const UpdateTricycleForm({super.key});

  @override
  State<UpdateTricycleForm> createState() => _UpdateTricycleFormState();
}

class _UpdateTricycleFormState extends State<UpdateTricycleForm> {
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: DelegatedText(text: "Update Tricycle", fontSize: 20),
            ),
            const delegatedForm(
                fieldName: "Plate Number",
                icon: Icons.numbers,
                hintText: "Enter plate Number"),
            const delegatedForm(
                fieldName: "Tricycle Color",
                icon: Icons.numbers,
                hintText: "Enter tricycle color"),
            SizedBox(
              width: size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform update operation
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Constants.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: DelegatedText(
                  fontSize: 20,
                  text: "Update",
                  color: Constants.secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
