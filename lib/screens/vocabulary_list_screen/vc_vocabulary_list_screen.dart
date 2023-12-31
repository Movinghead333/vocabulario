import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario/models/vc_phrase.dart';
import 'package:vocabulario/providers/vc_vocabulary_provider.dart';
import 'package:vocabulario/vc_constants.dart';
import 'package:vocabulario/vc_routes.dart';
import 'package:vocabulario/widgets/vc_centered_loading_indicator.dart';

/// This screen is responsible for displaying all phrases with detailed
/// information within a scrollable list.
class VcVocabularyListScreen extends StatefulWidget {
  const VcVocabularyListScreen({super.key});

  @override
  State<VcVocabularyListScreen> createState() => _VcVocabularyListScreenState();
}

class _VcVocabularyListScreenState extends State<VcVocabularyListScreen> {
  @override
  Widget build(BuildContext context) {
    VcVocabularyProvider vocabularyProvider =
        Provider.of<VcVocabularyProvider>(context);

    return Scaffold(
      body: StreamBuilder(
        stream: vocabularyProvider.phrasesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const VcCenteredLoadingIndicator();
          }

          List<VcPhrase> phrases = snapshot.data!;

          return ListView.builder(
            itemCount: phrases.length,
            itemBuilder: (context, index) {
              VcPhrase phrase = phrases[index];
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      phrase.sourceWord,
                      style: kVcMediumTextStyle,
                    ),
                    Text(
                      '${phrase.successRate.toString()}% SR',
                      style: kVcMediumTextStyle,
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: phrase.translations
                      .map((translation) => Text(translation))
                      .toList(),
                ),
                onTap: () {
                  vocabularyProvider.phraseSelectedForEdit = phrase;
                  Navigator.pushNamed(
                      context, VcRoutes.addOrEditPhraseScreenName);
                },
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Reset the phraseSelectedForEdit since we are creating a new phrase.
          vocabularyProvider.phraseSelectedForEdit = null;

          // Navigate to add or edit word screen
          Navigator.pushNamed(context, VcRoutes.addOrEditPhraseScreenName);
        },
      ),
    );
  }
}
