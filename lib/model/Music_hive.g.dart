// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Music_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusicHiveAdapter extends TypeAdapter<MusicHive> {
  @override
  final int typeId = 0;

  @override
  MusicHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusicHive(
      TrackName: fields[1] as dynamic,
      Albumname: fields[3] as dynamic,
      Singers: fields[2] as dynamic,
      TrackID: fields[0] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, MusicHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.TrackID)
      ..writeByte(1)
      ..write(obj.TrackName)
      ..writeByte(2)
      ..write(obj.Singers)
      ..writeByte(3)
      ..write(obj.Albumname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
