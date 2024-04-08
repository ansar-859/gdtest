import 'package:flutter/material.dart';

import 'package:gdtest/presentation/screens/profile_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool canGoBack;
  final bool isProfileRequire;

  const CustomAppBar({
    required this.title,
    this.canGoBack = false,
    this.isProfileRequire = true,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];

    if (isProfileRequire) {
      actions.add(
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            // Navigate to the Profile screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
      );
    }

    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.75),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: AppBar(
          automaticallyImplyLeading: canGoBack,
          leading: canGoBack
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : null,
          title: Text(title),
          centerTitle: true,
          actions: actions,
        ));
  }
}
