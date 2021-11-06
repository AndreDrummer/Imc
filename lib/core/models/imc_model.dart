import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

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

  ImcModel({
    required this.description,
    required this.imcValue,
    required this.height,
    required this.weight,
    required this.id,
  });

  factory ImcModel.fromJson(Map<String, dynamic> json) =>
      _$ImcModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImcModelToJson(this);

  factory ImcModel.initial() {
    return ImcModel(
      description: '',
      imcValue: 0.0,
      height: 0.0,
      weight: 0.0,
      id: '',
    );
  }
}
