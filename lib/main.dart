import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdtest/bloc/auth/auth_bloc.dart';
import 'package:gdtest/bloc/movie/movie_bloc.dart';
import 'package:gdtest/data/repositories/auth_repository.dart';
import 'package:gdtest/data/repositories/movie_repository.dart';
import 'package:gdtest/firebase_options.dart';
import 'package:gdtest/presentation/screens/auth/sign_in.dart';
import 'package:gdtest/presentation/screens/home_screen.dart';

import 'presentation/theme/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //auto generated from flutterfire CLI
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => MovieRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
            create: (context) => MovieBloc(
                movieRepository:
                    RepositoryProvider.of<MovieRepository>(context)),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: CustomTheme.darkTheme(context),
          themeMode: ThemeMode.dark,
          home: StreamBuilder<User?>(
            //fetching user session status
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // user session existing, take to home
                return HomeScreen(currentUser: snapshot.data!);
              }
              //No session, ask for login
              return SignIn();
            },
          ),
        ),
      ),
    );
  }
}
