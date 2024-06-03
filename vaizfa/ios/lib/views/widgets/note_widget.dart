import 'package:flutter/material.dart';

import '../../models/note_models.dart';

class NoteWidget extends StatefulWidget {
  final int id;
  final NoteModels noteModels;
  final Function() onDelete;
  final Function() onEdit;
  final Function() onTapp;
  NoteWidget(
      {super.key,
      required this.id,
      required this.noteModels,
      required this.onDelete,
      required this.onEdit,
      required this.onTapp});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTapp,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${widget.id + 1}.',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ],
      ),
      title: Text(
        widget.noteModels.title,
        style: const TextStyle(
            decorationThickness: 1.5,
            fontWeight: FontWeight.w600,
            fontSize: 17),
      ),
      subtitle: Text(widget.noteModels.data),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: widget.onEdit,
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: widget.onDelete,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
