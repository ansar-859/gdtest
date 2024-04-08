import 'package:flutter_test/flutter_test.dart';
import 'package:gdtest/bloc/movie/movie_bloc.dart';
import 'package:gdtest/data/repositories/movie_repository.dart';
import 'package:mockito/mockito.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  group('MovieBloc', () {
    late MovieBloc movieBloc;
    late MockMovieRepository mockMovieRepository;

    setUp(() {
      mockMovieRepository = MockMovieRepository();
      movieBloc = MovieBloc(movieRepository: mockMovieRepository);
    });

    tearDown(() {
      movieBloc.close();
    });

    test(
        'Given movie screen When bloc initialization Then map to MovieInitial state',
        () {
      expect(movieBloc.state, MovieInitial());
    });
  });
}
