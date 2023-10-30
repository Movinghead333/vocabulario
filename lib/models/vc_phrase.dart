/// A [VcPhrase] represents a single word in a foreign language with its
/// translations.
/// Additionally information about how often the translation was attempted and
/// how many of these attempts were successful are stored.
class VcPhrase {
  String sourceWord;
  List<String> translations;
  int successfulAttempts = 0;
  int allAttempts = 0;

  VcPhrase({required this.sourceWord, required this.translations});

  int get successRate => allAttempts > 0
      ? successfulAttempts.toDouble() * 100 ~/ allAttempts.toDouble()
      : 0;
}
