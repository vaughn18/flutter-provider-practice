import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './services/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/home.dart';
import './providers/settings_provider.dart';
import './screens/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FirestoreService _db = FirestoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => SettingsProvider()),
        StreamProvider(create: (BuildContext context) => _db.getReports())
      ],
      child: MaterialApp(
          title: 'Wax App',
          theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              accentColor: Colors.deepOrangeAccent),
          home: Home(),
          routes: {
            SettingsScreen.routeName: (ctx) => SettingsScreen(),
          } //routes,
          ),
    );
  }
}
