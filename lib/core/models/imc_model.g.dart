// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImcModelAdapter extends TypeAdapter<ImcModel> {
  @override
  final int typeId = 4;

  @override
  ImcModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImcModel(
      description: fields[0] as String,
      imcValue: fields[1] as double,
      height: fields[2] as double,
      weight: fields[3] as double,
      id: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImcModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.imcValue)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImcModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImcModel _$ImcModelFromJson(Map<String, dynamic> json) {
  return ImcModel(
    description: json['description'] as String,
    imcValue: (json['imcValue'] as num).toDouble(),
    height: (json['height'] as num).toDouble(),
    weight: (json['weight'] as num).toDouble(),
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$ImcModelToJson(ImcModel instance) => <String, dynamic>{
      'description': instance.description,
      'imcValue': instance.imcValue,
      'height': instance.height,
      'weight': instance.weight,
      'id': instance.id,
    };
