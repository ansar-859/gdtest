import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gdtest/data/models/movie.dart';
import 'package:gdtest/presentation/widgets/movie_preview_card.dart';

void main() {
  testWidgets(
      'Given a movie When rendering related movie Then finds movie title and image',
      (WidgetTester tester) async {
    // a test Movie object
    final movie = Movie(
      title: 'Test Movie',
      imagePath: 'assets/images/1.jpg',
      comments: ['Comment 1', 'Comment 2'],
      isCommentAllowed: true,
    );

    await tester.pumpWidget(MaterialApp(
      home: MoviePreviewCard(movie: movie),
    ));

    // Verify that the move preview widget has title and image
    expect(find.text('Test Movie'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
