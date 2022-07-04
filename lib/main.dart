import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:porelab_bubblepoint/config/app_colors.dart';
import 'package:porelab_bubblepoint/controller/provider/folder_structure_provider.dart';
import 'package:porelab_bubblepoint/folder_structure/folder_structure.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'controller/provider/test_setup_provider.dart';

void main() async {

  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Firestore.initialize("nyiapp-3a612");
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
        home: FolderStructure(),
      ),
    );
  }
}

