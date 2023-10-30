import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario/models/vc_phrase.dart';
import 'package:vocabulario/models/vc_translation_status.dart';
import 'package:vocabulario/providers/vc_vocabulary_provider.dart';
import 'package:vocabulario/screens/check_phrase_screen/widgets/vc_numbered_text_field.dart';
import 'package:vocabulario/vc_constants.dart';
import 'package:vocabulario/widgets/vc_centered_error_message.dart';
import 'package:vocabulario/widgets/vc_centered_loading_indicator.dart';

/// This screen handles the main feature of the app: translating vocabulary.
///
/// This is done by displaying the currently selected [VcPhrase] and asking the
/// user for its translations. After the user entered the translation, the
/// translations can be checked and a feedback about the provided translations
/// is given to the user.
class VcCheckPhraseScreen extends StatefulWidget {
  const VcCheckPhraseScreen({super.key});

  @override
  State<VcCheckPhraseScreen> createState() => _VcCheckPhraseScreenState();
}

class _VcCheckPhraseScreenState extends State<VcCheckPhraseScreen> {
  StreamSubscription<VcTranslationStatus>? subscription;

  late VcVocabularyProvider vocabularyProvider;
  List<TextEditingController> textFieldControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void onTextFieldFocus() {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      if (scrollController.position.pixels !=
              scrollController.position.maxScrollExtent &&
          scrollController.position.maxScrollExtent > 0) {
        scrollController.animateTo(180.0,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    vocabularyProvider = Provider.of<VcVocabularyProvider>(context);
    _addTranslationStatusListener();

    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<VcPhrase?>(
            stream: vocabularyProvider.selectedPhraseStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const VcCenteredErrorMessage();
              }

              VcPhrase? phraseData = snapshot.data;
              if (snapshot.hasData && phraseData != null) {
                return Column(
                  children: [
                    const Text(
                      'Translate:',
                      textAlign: TextAlign.center,
                      style: kVcLargeTextStyle,
                    ),
                    Text(
                      phraseData.sourceWord,
                      style: kVcMediumTextStyle,
                    ),
                    const Divider(height: 20, thickness: 2),
                    const Text(
                      'My translation(s):',
                      textAlign: TextAlign.center,
                      style: kVcLargeTextStyle,
                    ),
                    VcNumberedTextField(
                      number: 1,
                      textFieldController: textFieldControllers[0],
                      onFocus: onTextFieldFocus,
                      hintText: '1st translation',
                    ),
                    VcNumberedTextField(
                      number: 2,
                      textFieldController: textFieldControllers[1],
                      onFocus: onTextFieldFocus,
                      hintText: '2nd translation',
                    ),
                    VcNumberedTextField(
                      number: 3,
                      textFieldController: textFieldControllers[2],
                      onFocus: onTextFieldFocus,
                      hintText: '3rd translation',
                    ),
                    VcNumberedTextField(
                      number: 4,
                      textFieldController: textFieldControllers[3],
                      onFocus: onTextFieldFocus,
                      hintText: '4th translation',
                    ),
                    const Divider(height: 40, thickness: 2),
                    StreamBuilder<VcTranslationStatus>(
                        initialData: VcTranslationStatus.inProgress,
                        stream: vocabularyProvider.translationStatusStream,
                        builder: (context, snapshot) {
                          VcTranslationStatus translationStatus =
                              snapshot.data!;

                          String buttonText = 'Next';
                          Color backgroundColor = kVcLightGrayBackgroundColor;
                          Color textColor = kVcNeutralTextColor;

                          switch (translationStatus) {
                            case VcTranslationStatus.inProgress:
                              buttonText = 'Check';

                            case VcTranslationStatus.valid:
                              backgroundColor = kVcLightGreenBackgroundColor;
                              textColor = kVcGreenTextColor;
                            case VcTranslationStatus.invalid:
                              backgroundColor = kVcLightRedBackgroundColor;
                              textColor = kVcRedTextColor;

                            case VcTranslationStatus.partiallyValid:
                              backgroundColor = kVcLightYellowBackgroundColor;
                              textColor = kVcYellowTextColor;
                          }

                          return ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  backgroundColor),
                            ),
                            onPressed: () {
                              vocabularyProvider.checkOrNextButtonPressed(
                                textFieldControllers[0].text,
                                textFieldControllers[1].text,
                                textFieldControllers[2].text,
                                textFieldControllers[3].text,
                              );

                              if (translationStatus !=
                                  VcTranslationStatus.inProgress) {
                                for (TextEditingController controller
                                    in textFieldControllers) {
                                  controller.clear();
                                }
                              }
                            },
                            child: Text(
                              buttonText,
                              style:
                                  kVcMediumTextStyle.copyWith(color: textColor),
                            ),
                          );
                        }),
                  ],
                );
              } else {
                return const VcCenteredLoadingIndicator();
              }
            }),
      ),
    );
  }

  String _createMissingOrIncorrectTranslationsString(
      List<String> nonValidTranslations) {
    String result = '';

    if (vocabularyProvider.unmatchedTranslationsList.isNotEmpty) {
      result += '\n\nThe following translations could not be matched:';
      for (String vocab in vocabularyProvider.unmatchedTranslationsList) {
        result += '\n$vocab';
      }
    }

    if (vocabularyProvider.incorrectTranslationsList.isNotEmpty) {
      result += '\n\nThe following translations you entered were incorrect:';
      for (String translation in vocabularyProvider.incorrectTranslationsList) {
        result += '\n$translation';
      }
    }

    return result;
  }

  void _addTranslationStatusListener() {
    if (subscription != null) {
      return;
    }

    subscription = vocabularyProvider.translationStatusStream.listen(
      (newTranslationStatus) {
        if (newTranslationStatus == VcTranslationStatus.invalid) {
          showDialog(
            context: context,
            builder: (context) {
              String content =
                  'Your translation for the word ${vocabularyProvider.selectedPhrase!.sourceWord} is wrong. ${_createMissingOrIncorrectTranslationsString(vocabularyProvider.unmatchedTranslationsList)}';

              return AlertDialog(
                title: const Text('Wrong translation'),
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
        } else if (newTranslationStatus == VcTranslationStatus.partiallyValid) {
          showDialog(
            context: context,
            builder: (context) {
              String content =
                  'Your translation for the word ${vocabularyProvider.selectedPhrase!.sourceWord} was only partially correct. ${_createMissingOrIncorrectTranslationsString(vocabularyProvider.unmatchedTranslationsList)}';

              return AlertDialog(
                title: const Text('Partially correct translation'),
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
        }
      },
    );
  }
}
