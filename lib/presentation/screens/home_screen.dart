import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdtest/bloc/movie/movie_bloc.dart';
import 'package:gdtest/presentation/widgets/custom_app_bar.dart';
import 'package:gdtest/presentation/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  final User currentUser;

  const HomeScreen({required this.currentUser, Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    _movieBloc = BlocProvider.of<MovieBloc>(context);
    _movieBloc.add(MovieLoadRequested()); // Trigger the event to load movies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Explore Videos',
        canGoBack: false,
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieInitial || state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                return MovieCard(selectedMovie: state.movies[index]);
              },
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
