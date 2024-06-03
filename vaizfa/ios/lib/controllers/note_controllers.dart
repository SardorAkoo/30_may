
import '../models/note_models.dart';

class NoteControllers {
  List<NoteModels> list = [
    NoteModels(
        title: 'What is Lorem Ipsum?',
        content:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
        data: '2025-02-12'),
    NoteModels(
        title: 'Where does it come from?',
        content:
            'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in',
        data: '2024-05-06'),
  ];

  void add(String title, String content, String data) {
    list.add(NoteModels(title: title, content: content, data: data));
  }

  void delete(int index) {
    list.removeAt(index);
  }

  void edit(String title, String content, String data, int index) {
    list[index].title = title;
    list[index].data = data;
    list[index].content = content;
  }
}
