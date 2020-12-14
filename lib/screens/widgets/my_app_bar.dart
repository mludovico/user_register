import 'package:flutter/material.dart';
import 'package:user_register/constants/ui_styles.dart';

class MyAppBar extends AppBar {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primary,
      centerTitle: true,
      title: Text('My Awesome Registration App'),
      actions: [
        IconButton(
          icon: Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
          onPressed: showInfo,
        ),
        IconButton(
          icon: Icon(
            Icons.translate,
            color: Colors.white,
          ),
          onPressed: showTranslation,
        ),
      ],
    );
  }

  showInfo() => print('Show info modal');
  showTranslation() => print('Show translation modal');

}
