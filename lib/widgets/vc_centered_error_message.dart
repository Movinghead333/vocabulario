import 'package:flutter/material.dart';
import 'package:vocabulario/vc_constants.dart';

/// Default widget for display errors within the app.
class VcCenteredErrorMessage extends StatelessWidget {
  const VcCenteredErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Error', style: kVcMediumTextStyle),
    );
  }
}
