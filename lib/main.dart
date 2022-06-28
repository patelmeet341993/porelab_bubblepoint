import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/views/login_page/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'controller/provider/test_setup_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (BuildContext context)  => TestSetupProvider(),
      lazy: false,
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: AppColors.backGroundColor),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}

