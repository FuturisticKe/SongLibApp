// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Listed _$ListedFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'objectId',
      'parentid',
      'title',
      'description',
      'position',
      'createdAt',
      'updatedAt'
    ],
  );
  return Listed(
    objectId: json['objectId'] as String,
    parentid: json['parentid'] as int?,
    title: json['title'] as String,
    description: json['description'] as String,
    position: json['position'] as int?,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$ListedToJson(Listed instance) {
  final val = <String, dynamic>{
    'objectId': instance.objectId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('parentid', instance.parentid);
  val['title'] = instance.title;
  val['description'] = instance.description;
  writeNotNull('position', instance.position);
  val['createdAt'] = instance.createdAt;
  val['updatedAt'] = instance.updatedAt;
  writeNotNull('id', instance.id);
  return val;
}