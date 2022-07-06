import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'package:firedart/firedart.dart'as fireDart;
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/controller/provider/folder_structure_provider.dart';
import 'package:porelab_bubblepoint/folder_structure/folder_structure.dart';
import 'package:porelab_bubblepoint/views/login_page/screens/login_screen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'controller/provider/test_setup_provider.dart';
import 'package:firebase_core_dart/firebase_core_dart.dart' as core_dart;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  fireDart.Firestore.initialize("nyiapp-3a612");
  /*if([Platform.isAndroid, Platform.isIOS, Platform.isMacOS, kIsWeb].contains(true)) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  }*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TestSetupProvider(), ),
        ChangeNotifierProvider(create: (_) => FolderStructureProvider(), ),
      ],
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: AppColors.backGroundColor),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}

