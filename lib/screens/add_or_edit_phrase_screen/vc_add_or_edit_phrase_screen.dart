import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario/models/vc_phrase.dart';
import 'package:vocabulario/providers/vc_vocabulary_provider.dart';
import 'package:vocabulario/vc_constants.dart';

/// This screen is responsible for both adding and editing [VcPhrase]s.
class VcAddOrEditPhraseScreen extends StatefulWidget {
  const VcAddOrEditPhraseScreen({super.key});

  @override
  State<VcAddOrEditPhraseScreen> createState() =>
      _VcAddOrEditPhraseScreenState();
}

class _VcAddOrEditPhraseScreenState extends State<VcAddOrEditPhraseScreen> {
  late VcVocabularyProvider vocabularyProvider;

  TextEditingController sourceWordTextEditingController =
      TextEditingController();

  List<TextEditingController> translationTextEdetingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    vocabularyProvider = Provider.of<VcVocabularyProvider>(context);

    VcPhrase? phrase = vocabularyProvider.phraseSelectedForEdit;

    if (phrase != null) {
      sourceWordTextEditingController.text = phrase.sourceWord;
      for (int i = 0; i < phrase.translations.length; i++) {
        translationTextEdetingControllers[i].text = phrase.translations[i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddOrEditPhraseScreen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Source word to translate',
                style: kVcLargeTextStyle,
              ),
              TextField(
                style: kVcMediumTextStyle,
                decoration:
                    const InputDecoration(hintText: 'phrase, e.g. "que"'),
                controller: sourceWordTextEditingController,
              ),
              const Divider(thickness: 2, height: 40),
              const Text(
                'Translations:',
                style: kVcLargeTextStyle,
              ),
              TextField(
                style: kVcMediumTextStyle,
                decoration: const InputDecoration(
                  hintText: '1st translation, e.g. "dass"',
                ),
                controller: translationTextEdetingControllers[0],
              ),
              TextField(
                style: kVcMediumTextStyle,
                decoration: const InputDecoration(
                    hintText: '2nd translation, e.g. "was"'),
                controller: translationTextEdetingControllers[1],
              ),
              TextField(
                style: kVcMediumTextStyle,
                decoration: const InputDecoration(hintText: '3rd translation'),
                controller: translationTextEdetingControllers[2],
              ),
              TextField(
                style: kVcMediumTextStyle,
                decoration: const InputDecoration(hintText: '4th translation'),
                controller: translationTextEdetingControllers[3],
              ),
              const Divider(thickness: 2, height: 40),
              ElevatedButton(
                onPressed: () {
                  if (sourceWordTextEditingController.text == '') {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String content =
                            'Please provide a phrase to be translated.';

                        return AlertDialog(
                          title: const Text('Empty input'),
                          content: Text(content),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('ok'),
                            )
                          ],
                        );
                      },
                    );
                    return;
                  }

                  if (!translationTextEdetingControllers
                      .any((element) => element.text.isNotEmpty)) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String content =
                            'Please provide at least one translation for the given phrase.';

                        return AlertDialog(
                          title: const Text('Empty input'),
                          content: Text(content),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('ok'),
                            )
                          ],
                        );
                      },
                    );
                    return;
                  }

                  vocabularyProvider.saveOrUpdatePhrase(
                    sourceWordTextEditingController.text,
                    translationTextEdetingControllers[0].text,
                    translationTextEdetingControllers[1].text,
                    translationTextEdetingControllers[2].text,
                    translationTextEdetingControllers[3].text,
                  );

                  Navigator.pop(context);
                },
                child: const Text(
                  'Save',
                  style: kVcLargeTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
