import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gdtest/data/models/movie.dart';
import 'package:gdtest/presentation/widgets/movie_card.dart';

void main() {
  testWidgets(
      'Given a movie When rendering related movies Then finds icon for comments',
      (WidgetTester tester) async {
    // a test Movie object
    final movie = Movie(
      title: 'Test Movie',
      imagePath: 'assets/images/1.jpg',
      comments: ['Comment 1', 'Comment 2'],
      isCommentAllowed: false,
    );

    // Build the MovieCard widget
    await tester.pumpWidget(MaterialApp(
      home: MovieCard(selectedMovie: movie),
    ));

    expect(find.byType(Icon), findsOneWidget);
  });
}
