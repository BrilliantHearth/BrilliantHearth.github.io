import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'controllers/home_page_controller.dart';

void main() {
  runApp(BrilliantHearthWebsite());
}


class BrilliantHearthWebsite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage() ,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        );
      },
    );
  }
}

