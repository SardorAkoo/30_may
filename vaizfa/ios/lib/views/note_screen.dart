import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/note_controllers.dart';
import 'content.dart';
import 'drawer.dart';
import 'widgets/add_note.dart';
import 'widgets/note_widget.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  NoteControllers noteControllers = NoteControllers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic>? data = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) {
              return AddNote();
            },
          );

          if (data?['title'] != null) {
            if (data!['date'] != '') {
              noteControllers.add(data['title'], data['content'], data['date']);
            } else {
              noteControllers.add(data['title'], data['content'],
                  DateTime.now().toString().split(' ')[0]);
            }
          }

          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      drawer: Drawers(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Notes',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      body: ListView.builder(
          itemCount: noteControllers.list.length,
          itemBuilder: (ctx, index) {
            return NoteWidget(
                id: index,
                noteModels: noteControllers.list[index],
                onDelete: () {
                  noteControllers.delete(index);
                  setState(() {});
                },
                onEdit: () async {
                  Map<String, dynamic>? data = await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (ctx) {
                      return AddNote();
                    },
                  );
                  if (data?['date'] == '') {
                    print(data?['date'].runtimeType);
                    noteControllers.edit(data!['title'], data!['content'],
                        DateTime.now().toString().split(' ')[0], index);
                  } else {
                    noteControllers.edit(
                        data!['title'], data['content'], data['date'], index);
                  }

                  setState(() {});
                },
                onTapp: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => Content(
                              title: noteControllers.list[index].title,
                              content: noteControllers.list[index].content,
                              date: noteControllers.list[index].data)));
                });
          }),
    );
  }
}
