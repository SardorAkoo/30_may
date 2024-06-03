import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _formFiled = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _contentTextEditingController = TextEditingController();
  TextEditingController _dateTextEditingController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? _dateTime = await showDatePicker(
        context: context, firstDate: DateTime(2023), lastDate: DateTime(2025));
    if (_dateTime.toString().isNotEmpty) {
      _dateTextEditingController.text = _dateTime.toString().split(' ')[0];
      setState(() {});
    } else {
      _dateTextEditingController.text = DateTime.now().toString().split(' ')[0];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 24,
      title: const Text(
        'Add Note',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        textAlign: TextAlign.center,
      ),
      content: Container(
        width: 270,
        height: 350,
        child: Form(
            key: _formFiled,
            child: Column(
              children: [
                TextFormField(
                  controller: _textEditingController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter note title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      label: Text('Enter note title'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                Gap(20),
                TextFormField(
                  controller: _contentTextEditingController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter note content';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      label: Text('Enter note content'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                Gap(20),
                TextFormField(
                  controller: _dateTextEditingController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            _selectDate();
                          },
                          icon: Icon(Icons.calendar_month)),
                      label: Text('dd-mm-yyyy'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                )
              ],
            )),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                )),
            TextButton(
                onPressed: () {
                  if (_formFiled.currentState!.validate()) {
                    Navigator.pop(context, {
                      'title': _textEditingController.text,
                      'content': _contentTextEditingController.text,
                      'date': _dateTextEditingController.text,
                    });
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                )),
          ],
        )
      ],
    );
  }
}
