import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class JobModel {
  final String idUser;
  final String weightJob;
  final String lat;
  final String lng;
  JobModel({
    required this.idUser,
    required this.weightJob,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idUser': idUser,
      'weightJob': weightJob,
      'lat': lat,
      'lng': lng,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      idUser: map['idUser'] as String,
      weightJob: map['weightJob'] as String,
      lat: map['lat'] as String,
      lng: map['lng'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromJson(String source) =>
      JobModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
