import 'dart:math';

import 'package:rxdart/rxdart.dart';
import 'package:vocabulario/mock/vc_mock_data.dart';
import 'package:vocabulario/models/vc_phrase.dart';
import 'package:vocabulario/models/vc_translation_status.dart';

/// This provider handles all functionality related to accessing and
/// manipulating [VcPhrase]s.
class VcVocabularyProvider {
  // #region phrases BehaviorSubject
  final BehaviorSubject<List<VcPhrase>> _phrasesSubject =
      BehaviorSubject.seeded([]);

  set phrases(List<VcPhrase> newPhrases) {
    _phrasesSubject.add(newPhrases);
  }

  List<VcPhrase> get phrases => _phrasesSubject.value;

  Stream<List<VcPhrase>> get phrasesStream => _phrasesSubject.stream;
  // #endregion

  // #region selectedPhrase BehaviorSubject
  final BehaviorSubject<VcPhrase?> _selectedPhraseSubject =
      BehaviorSubject<VcPhrase?>.seeded(null);

  set selectedPhrase(VcPhrase? newSelectedPhrase) {
    _selectedPhraseSubject.add(newSelectedPhrase);
  }

  VcPhrase? get selectedPhrase => _selectedPhraseSubject.value;

  Stream<VcPhrase?> get selectedPhraseStream => _selectedPhraseSubject.stream;
  // #endregion

  // #region translationStatus BehaviorSubject
  final BehaviorSubject<VcTranslationStatus> _translationStatusSubject =
      BehaviorSubject<VcTranslationStatus>.seeded(
          VcTranslationStatus.inProgress);

  set translationStatus(VcTranslationStatus newtranslationStatus) {
    _translationStatusSubject.add(newtranslationStatus);
  }

  VcTranslationStatus get translationStatus => _translationStatusSubject.value;

  Stream<VcTranslationStatus> get translationStatusStream =>
      _translationStatusSubject.stream;
  // #endregion

  VcVocabularyProvider() {
    phrases = VcMockData.getPhrasesData();
    chooseNewSelectedPhrase();
  }

  List<String> matchedTranslationsList = [];
  List<String> unmatchedTranslationsList = [];
  List<String> incorrectTranslationsList = [];

  VcPhrase? phraseSelectedForEdit;

/*
-------------------------------- Business Logic --------------------------------
*/
  void chooseNewSelectedPhrase() {
    if (phrases.isNotEmpty) {
      int randomChoice = Random().nextInt(phrases.length);

      selectedPhrase = phrases[randomChoice];
    }
  }

  /// Either checks the given translation against the currently selected phrase
  /// or proceeds to the next phrase.
  void checkOrNextButtonPressed(
    String translation1,
    String translation2,
    String translation3,
    String translation4,
  ) {
    if (selectedPhrase == null) {
      return;
    }

    if (translationStatus == VcTranslationStatus.inProgress) {
      List<String> userTranslations = [
        translation1,
        translation2,
        translation3,
        translation4
      ];

      // If none of the tranlations is a non empty string, then return since
      // there are no translations to check against.
      if (!userTranslations.any((element) => element.isNotEmpty)) {
        return;
      }

      Set<String> transformedUserTranslationsSet = userTranslations
          .map<String>(_transformUserTranslation)
          .where((element) => element.isNotEmpty)
          .toSet();

      Set<String> correctTranslationsSet = selectedPhrase!.translations.toSet();

      Set<String> matchedTranslationsSet =
          correctTranslationsSet.intersection(transformedUserTranslationsSet);

      matchedTranslationsList = matchedTranslationsSet.toList()..sort();
      unmatchedTranslationsList = correctTranslationsSet
          .difference(matchedTranslationsSet)
          .toList()
        ..sort();
      incorrectTranslationsList = transformedUserTranslationsSet
          .difference(correctTranslationsSet)
          .toList()
        ..sort();

      int numberOfMatchedTranslations = matchedTranslationsSet.length;
      int numberOfIncorrectTranslations = incorrectTranslationsList.length;

      if (numberOfMatchedTranslations == 0) {
        translationStatus = VcTranslationStatus.invalid;
      } else if (numberOfMatchedTranslations == correctTranslationsSet.length &&
          numberOfIncorrectTranslations == 0) {
        selectedPhrase!.successfulAttempts += 1;
        translationStatus = VcTranslationStatus.valid;
      } else {
        translationStatus = VcTranslationStatus.partiallyValid;
      }
      selectedPhrase!.allAttempts += 1;
    } else {
      translationStatus = VcTranslationStatus.inProgress;
      chooseNewSelectedPhrase();
    }
  }

  void saveOrUpdatePhrase(
    String sourceWord,
    String translation1,
    String translation2,
    String translation3,
    String translation4,
  ) {
    List<String> nonEmptyTranslations = [];

    if (translation1.isNotEmpty) nonEmptyTranslations.add(translation1);
    if (translation2.isNotEmpty) nonEmptyTranslations.add(translation2);
    if (translation3.isNotEmpty) nonEmptyTranslations.add(translation3);
    if (translation4.isNotEmpty) nonEmptyTranslations.add(translation4);

    if (phraseSelectedForEdit == null) {
      VcPhrase newPhrase =
          VcPhrase(sourceWord: sourceWord, translations: nonEmptyTranslations);

      // Add the new phrase and use the setter to force the addition of a new
      // item into stream so the UI refreshes.
      phrases = phrases..add(newPhrase);
    } else {
      phraseSelectedForEdit!.sourceWord = sourceWord;
      phraseSelectedForEdit!.translations = nonEmptyTranslations;
    }
  }

  String _transformUserTranslation(String userTranslation) {
    userTranslation = userTranslation.trim();

    return userTranslation;
  }
}
