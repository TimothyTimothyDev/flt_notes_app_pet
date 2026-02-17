import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/model/notes.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.read<NotesProvider>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.red[300],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Form(
                key: data.formKey,
                child: Column(
                  children: [
                    CustomTextForm(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return 'The title cannot be empty';
                        }
                        return null;
                      },
                      controller: data.titleController,
                      hintText: 'Note name',
                      maxLines: 1,
                    ),
                    const SizedBox(height: 10),
                    CustomTextForm(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return 'The description cannot be empty';
                        }
                        return null;
                      },
                      controller: data.subtitleController,
                      hintText: 'Notes description',
                      maxLines: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(),
              const SizedBox(height: 10),
              CustomListView(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final FormFieldValidator<String>? validator;

  const CustomTextForm({
    super.key,
    required this.controller,
    required this.hintText,
    required this.maxLines,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  const CustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<NotesProvider>();
    return Expanded(
      child: ListView.builder(
        itemCount: data.notes.length,
        itemBuilder: (context, index) {
          final items = data.notes[index];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/view_page',
                  arguments: data.notes[index],
                );
              },
              leading:
                  CustomContainer(), // Icon(Icons.note, color: Colors.blue),
              title: Text(
                items.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                items.subtitle,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: CustomRemoveButton(index: index),
            ),
          );
        },
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.read<NotesProvider>();
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final title = data.titleController.text;
          final subtitle = data.subtitleController.text;

          if (data.formKey.currentState!.validate()) {
            data.titleController.clear();
            data.subtitleController.clear();
            data.addNote(title, subtitle);
          }
        },
        child: Text('Create note'),
      ),
    );
  }
}

class CustomRemoveButton extends StatelessWidget {
  final int index;
  const CustomRemoveButton({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final data = context.read<NotesProvider>();
    return IconButton(
      onPressed: () {
        data.removeNote(index);
      },
      icon: Icon(Icons.delete, color: Colors.red),
    );
  }
}

class CustomContainer extends StatelessWidget {
  Color getRandomColor() {
    final random = Random();

    return Color.fromARGB(
      255,
      random.nextInt(256), // red
      random.nextInt(256), // green
      random.nextInt(256), // blue
    );
  }

  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: getRandomColor(),
    );
  }
}
