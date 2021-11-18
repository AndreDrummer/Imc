import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'imc_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class ImcModel extends HiveObject {
  @HiveField(0)
  String description;

  @HiveField(1)
  double imcValue;

  @HiveField(2)
  double height;

  @HiveField(3)
  double weight;

  @HiveField(4)
  String id;

  @HiveField(5)
  late int stars;

  @HiveField(6)
  DateTime dateTime;

  ImcModel({
    required this.description,
    required this.dateTime,
    required this.imcValue,
    required this.height,
    required this.weight,
    required this.id,
  }) {
    stars = calculateStars();
  }

  factory ImcModel.fromJson(Map<String, dynamic> json) =>
      _$ImcModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImcModelToJson(this);

  factory ImcModel.initial() {
    return ImcModel(
      dateTime: DateTime.now(),
      description: '',
      imcValue: 0.0,
      height: 0.0,
      weight: 0.0,
      id: '',
    );
  }

  int calculateStars() {
    if ((imcValue == 0.0)) {
      return 0;
    } else if (imcValue > 0.0 && imcValue < 18.6) {
      return 4;
    } else if (imcValue >= 18.6 && imcValue <= 24.9) {
      return 6;
    } else if (imcValue >= 24.9 && imcValue <= 29.9) {
      return 5;
    } else if (imcValue >= 24.9 && imcValue <= 34.9) {
      return 3;
    } else if (imcValue >= 34.9 && imcValue <= 39.9) {
      return 2;
    } else if (imcValue >= 40) {
      return 1;
    }
    return 1;
  }
}
