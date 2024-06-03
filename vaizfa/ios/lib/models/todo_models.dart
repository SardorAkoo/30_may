import 'package:json_annotation/json_annotation.dart';

part 'todo_models.g.dart';

@JsonSerializable()
class TodoModels {
  String id;
  String name;
  String date;
  bool isDone;

  TodoModels(
      {required this.id,
      required this.name,
      required this.date,
      required this.isDone});

  factory TodoModels.fromJson(Map<String, dynamic> json) {
    return _$TodoModelsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TodoModelsToJson(this);
  }
}
