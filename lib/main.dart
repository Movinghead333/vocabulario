import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario/providers/vc_vocabulary_provider.dart';
import 'package:vocabulario/screens/add_or_edit_phrase_screen/vc_add_or_edit_phrase_screen.dart';
import 'package:vocabulario/screens/main_screen/vc_main_screen.dart';
import 'package:vocabulario/vc_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<VcVocabularyProvider>(
      create: (context) => VcVocabularyProvider(),
      child: MaterialApp(
        title: 'Vocabulary learning app.',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const VcMainScreen(),
        routes: {
          VcRoutes.mainScreenName: (context) => const VcMainScreen(),
          VcRoutes.addOrEditPhraseScreenName: (context) =>
              const VcAddOrEditPhraseScreen(),
        },
      ),
    );
  }
}
