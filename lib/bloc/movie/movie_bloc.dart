import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gdtest/data/models/movie.dart';
import 'package:gdtest/data/repositories/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(MovieInitial()) {
    on<MovieLoadRequested>((event, emit) async {
      emit(MovieLoading());
      try {
        final List<Movie> movies = movieRepository.fetchMovies();
        emit(MovieLoaded(movies: movies));
      } catch (e) {
        emit(MovieError(errorMessage: 'Failed to load movies'));
      }
    });
  }
}
