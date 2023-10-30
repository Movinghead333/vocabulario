import 'package:flutter/material.dart';
import 'package:vocabulario/vc_constants.dart';

class VcNumberedTextField extends StatefulWidget {
  const VcNumberedTextField({
    super.key,
    required this.number,
    required this.textFieldController,
    required this.onFocus,
    this.hintText,
  });

  final int number;
  final TextEditingController? textFieldController;
  final void Function()? onFocus;
  final String? hintText;

  @override
  State<VcNumberedTextField> createState() => _VcNumberedTextFieldState();
}

class _VcNumberedTextFieldState extends State<VcNumberedTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.onFocus != null) {
      debugPrint('Adding listerner');
      _focusNode.addListener(_onFocusChange);
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasPrimaryFocus) {
      widget.onFocus!();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onFocus != null) {
      _focusNode.removeListener(_onFocusChange);
    }
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Text('${widget.number}.', style: kVcMediumTextStyle),
        // const SizedBox(
        //   width: 10,
        // ),
        Expanded(
            child: TextField(
          decoration: InputDecoration(hintText: widget.hintText),
          focusNode: _focusNode,
          controller: widget.textFieldController,
          style: kVcMediumTextStyle,
        ))
      ],
    );
  }
}
