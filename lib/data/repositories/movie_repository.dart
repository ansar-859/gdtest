import 'dart:math';

import 'package:faker/faker.dart';

import 'package:gdtest/data/models/movie.dart';

class MovieRepository {
  List<Movie> fetchMovies() {
    return List.generate(10, fakeMovies);
  }

  Movie fakeMovies(int index) {
    final mov = Movie(
      title: faker.person.name(),
      imagePath: 'assets/images/${index + 1}.jpg',
      comments: List.generate(
        Random().nextInt(9) + 1,
        (index) => faker.lorem.sentence(),
      ),
      isCommentAllowed: Random().nextBool(),
    );

    return mov;
  }
}
