import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdtest/presentation/widgets/app_button.dart';
import 'package:gdtest/presentation/widgets/custom_app_bar.dart';

import 'package:gdtest/bloc/auth/auth_bloc.dart';
import 'auth/sign_in.dart';

class ProfileScreen extends StatefulWidget {
  static String id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUser = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'User Profile',
        canGoBack: true,
        isProfileRequire: false,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // clear backstack
            Navigator.of(context).popUntil((route) => route.isFirst);
            // Navigate to the login screen when sign-out is successful
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignIn()),
            );
          }
        },
        child: _currentUser != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: _currentUser.photoURL != null
                          ? NetworkImage(_currentUser.photoURL!)
                          : AssetImage('assets/images/default_user.png')
                              as ImageProvider,
                      radius: 50,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Name: ${_currentUser.displayName ?? ''}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Email: ${_currentUser.email ?? ''}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 120),
                    AppButton(
                      text: 'Sign Out',
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(SignOutRequested());
                      },
                      icon: Icons.logout,
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
