import 'package:flutter/material.dart';

/// Default loading screen content for the app.
class VcCenteredLoadingIndicator extends StatelessWidget {
  const VcCenteredLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
