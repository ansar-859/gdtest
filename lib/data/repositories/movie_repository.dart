import 'dart:math';

import 'package:faker/faker.dart';

import 'package:gdtest/data/models/movie.dart';

class MovieRepository {
  List<Movie> fetchMovies() {
    // get 10 fake movies
    return List.generate(10, fakeMovies);
  }

  //generate a fake movie with asset image as cover image
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
