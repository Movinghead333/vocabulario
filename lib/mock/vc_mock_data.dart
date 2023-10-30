import 'package:vocabulario/models/vc_phrase.dart';

/// This class provides mocked data for developing and testing the app.
class VcMockData {
  static List<VcPhrase> getPhrasesData() {
    return [
      VcPhrase(sourceWord: 'hola', translations: ['Hallo']),
      VcPhrase(sourceWord: 'comer', translations: ['essen']),
      VcPhrase(sourceWord: 'ser', translations: ['sein']),
      VcPhrase(sourceWord: 'que', translations: ['als', 'dass']),
      VcPhrase(
          sourceWord: 'muy', translations: ['sehr', 'äußerst', 'besonders']),
      VcPhrase(sourceWord: 'ahora', translations: ['jetzt', 'derzeit']),
      VcPhrase(sourceWord: 'casi', translations: ['fast', 'nahezu', 'beinahe']),
      VcPhrase(sourceWord: 'entonces', translations: ['denn', 'dann', 'also']),
      VcPhrase(sourceWord: 'donde', translations: ['wo', 'bei', 'zur']),
      VcPhrase(sourceWord: 'antes', translations: ['vorher', 'davor', 'zuvor']),
      VcPhrase(
          sourceWord: 'después', translations: ['danach', 'nachher', 'später']),
      VcPhrase(
          sourceWord: 'además',
          translations: ['außerdem', 'darüber hinaus', 'des Weiteren']),
      VcPhrase(
          sourceWord: 'tampoco', translations: ['auch nicht', 'auch kein']),
      VcPhrase(sourceWord: 'despacio', translations: ['langsam', 'gemächlich']),
      VcPhrase(
          sourceWord: 'todavía',
          translations: ['noch', 'noch immer', 'weiterhin']),
      VcPhrase(sourceWord: 'aún', translations: ['noch', 'noch immer']),
      VcPhrase(
          sourceWord: 'en general',
          translations: ['im Allgemeinen', 'normalerweise']),
      VcPhrase(sourceWord: 'quizá', translations: ['vielleicht']),
      VcPhrase(
          sourceWord: 'por supuesto',
          translations: ['allerdings', 'natürlich']),
      VcPhrase(
          sourceWord: 'bastante', translations: ['genug', 'ziemlich', 'recht']),
      VcPhrase(
          sourceWord: 'espicialmente',
          translations: ['besonders', 'insbesondere', 'speziell']),
      VcPhrase(
          sourceWord: 'demasiado', translations: ['zu', 'zu viel', 'zu groß']),
    ];
  }
}
