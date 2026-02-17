import 'package:flutter/material.dart';

class Notes {
  final String title;
  final String subtitle;

  Notes({required this.title, required this.subtitle});
}

class NotesProvider extends ChangeNotifier {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<Notes> notes = [];

  void addNote(String title, String subtitle) {
    final notesList = Notes(
      title: title,
      subtitle: subtitle,
    );
    notes.add(notesList);
    notifyListeners();
  }

  void removeNote(int index) {
    notes.removeAt(index);
    notifyListeners();
  }
}
