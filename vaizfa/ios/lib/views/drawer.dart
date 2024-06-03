import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'home_screen.dart';
import 'note_screen.dart';

class Drawers extends StatefulWidget {
  const Drawers({
    super.key,
  });

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(40),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
            },
            title: Text('Todo'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => Note()));
            },
            title: Text('Note'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}
