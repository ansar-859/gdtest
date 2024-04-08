import 'package:flutter/material.dart';
import 'package:gdtest/common/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gap Dynamics Test',
      debugShowCheckedModeBanner: false,
      darkTheme: CustomTheme.darkTheme(context),
      themeMode: ThemeMode.dark,
      home: const Center(child: Text('Flutter Demo Home Page')),
    );
  }
}
