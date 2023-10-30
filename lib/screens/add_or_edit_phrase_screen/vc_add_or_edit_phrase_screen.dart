import 'package:flutter/material.dart';

class VcAddOrEditPhraseScreen extends StatefulWidget {
  const VcAddOrEditPhraseScreen({super.key});

  @override
  State<VcAddOrEditPhraseScreen> createState() =>
      _VcAddOrEditPhraseScreenState();
}

class _VcAddOrEditPhraseScreenState extends State<VcAddOrEditPhraseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddOrEditPhraseScreen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Back'),
          onPressed: () {
            // Navigate back
          },
        ),
      ),
    );
  }
}
