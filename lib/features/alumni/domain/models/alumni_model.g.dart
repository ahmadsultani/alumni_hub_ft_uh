// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alumni_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlumniModelImpl _$$AlumniModelImplFromJson(Map<String, dynamic> json) =>
    _$AlumniModelImpl(
      idAlumni: (json['id_alumni'] as num).toInt(),
      idUser: (json['id_user'] as num).toInt(),
      nim: json['nim'] as String,
      NoAnggota: json['no_anggota'] as String?,
      nama: json['nama'] as String,
      tglLahir: json['tgl_lahir'] as String,
      jurusan: json['jurusan'] as String,
      angkatan: json['angkatan'] as String,
      kelamin: json['kelamin'] as String,
      agama: json['agama'] as String,
      golonganDarah: json['golongan_darah'] as String,
      validated: json['validated'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$AlumniModelImplToJson(_$AlumniModelImpl instance) =>
    <String, dynamic>{
      'id_alumni': instance.idAlumni,
      'id_user': instance.idUser,
      'nim': instance.nim,
      'no_anggota': instance.NoAnggota,
      'nama': instance.nama,
      'tgl_lahir': instance.tglLahir,
      'jurusan': instance.jurusan,
      'angkatan': instance.angkatan,
      'kelamin': instance.kelamin,
      'agama': instance.agama,
      'golongan_darah': instance.golonganDarah,
      'validated': instance.validated,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
