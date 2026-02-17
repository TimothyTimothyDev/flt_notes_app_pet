import 'package:flutter/material.dart';
import 'package:notes_app/model/notes.dart';
import 'package:notes_app/pages/main_page.dart';
import 'package:notes_app/pages/view_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NotesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(
            seedColor: Colors.deepPurple,
          ),
        ),
        home: const MainPage(),
        routes: {'/view_page': (context) => ViewPage()},
      ),
    );
  }
}
