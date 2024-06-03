import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditTodo extends StatefulWidget {
  final int index;
  EditTodo({super.key, required this.index});

  @override
  State<EditTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<EditTodo> {
  final _formFiled = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _dateTextEditingController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? _dateTime = await showDatePicker(
        context: context, firstDate: DateTime(2023), lastDate: DateTime(2025));
    if (_dateTime.toString().isNotEmpty) {
      _dateTextEditingController.text = _dateTime.toString().split(' ')[0];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 24,
      title: const Text(
        'Add todo',
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
                      return 'Please enter todo name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      label: Text('Enter todo name'),
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
                  'Canscel',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                )),
            TextButton(
                onPressed: () {
                  if (_formFiled.currentState!.validate()) {
                    Navigator.pop(context, {
                      'name': _textEditingController.text,
                      'date': _dateTextEditingController.text
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
