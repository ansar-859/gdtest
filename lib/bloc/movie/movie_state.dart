part of 'movie_bloc.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {
  List<Object> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MovieInitial;
}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  MovieLoaded({required this.movies});
}

class MovieError extends MovieState {
  final String errorMessage;

  MovieError({required this.errorMessage});
}
