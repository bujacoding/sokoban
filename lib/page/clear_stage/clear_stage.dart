import 'package:flutter/material.dart';

class ClearStagePopup extends StatefulWidget {
  const ClearStagePopup({Key? key, required this.level}) : super(key: key);

  final int level;

  @override
  State<ClearStagePopup> createState() => _ClearStagePopupState();
}

class _ClearStagePopupState extends State<ClearStagePopup> {
  FocusNode nextButtonFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
            child: Text(
          'Stage ${widget.level} Clear',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        )),
        SizedBox(height: 16),
        ElevatedButton(
            focusNode: nextButtonFocus..requestFocus(),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Next')),
      ],
    );
  }
}
