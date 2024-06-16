import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';
import 'screen/application_form.dart';
import 'screen/widget/internet_checker.dart';
import 'utils/core.dart';
// import 'screen/data/user_data.dart';

/// ----------------- entry point of app -----------------
Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  /// firebase init
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Hive offline database
  /// hive init
  await Hive.initFlutter();
  await Hive.openBox(AppString.hiveOpenDatabaseName);
  // Hive.registerAdapter(UserDataAdapter());
  // await Hive.openBox<UserData>('userDataBox');



  /// Internet checker
  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  /// ROOT ----- APP----------------
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ApplicationForm(),
    );
  }
}



