import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdtest/bloc/movie/movie_bloc.dart';
import 'package:gdtest/common/palette.dart';
import 'package:gdtest/data/models/movie.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_preview_card.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: movie.title, canGoBack: true),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.all(8),
              child: MovieCard(selectedMovie: movie, isDetailed: true),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Palette.almostBlack,
              alignment: Alignment.center,
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoaded) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: MoviePreviewCard(movie: state.movies[index]),
                        );
                      },
                    );
                  } else if (state is MovieError) {
                    return Center(child: Text(state.errorMessage));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
