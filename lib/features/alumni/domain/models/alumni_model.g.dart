// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alumni_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlumniModelImpl _$$AlumniModelImplFromJson(Map<String, dynamic> json) =>
    _$AlumniModelImpl(
      idAlumni: (json['id_alumni'] as num).toInt(),
      idUser: (json['id_user'] as num?)?.toInt(),
      nim: json['nim'] as String?,
      noAnggota: json['no_anggota'] as String?,
      noTelp: json['no_telp'] as String?,
      nama: json['nama'] as String,
      tglLahir: json['tgl_lahir'] as String,
      jurusan: json['jurusan'] as String,
      angkatan: json['angkatan'] as String,
      kelamin: json['kelamin'] as String?,
      agama: json['agama'] as String?,
      golonganDarah: json['golongan_darah'] as String?,
      validated: json['validated'] as bool?,
      isClaimed: json['is_claim'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$AlumniModelImplToJson(_$AlumniModelImpl instance) =>
    <String, dynamic>{
      'id_alumni': instance.idAlumni,
      'id_user': instance.idUser,
      'nim': instance.nim,
      'no_anggota': instance.noAnggota,
      'no_telp': instance.noTelp,
      'nama': instance.nama,
      'tgl_lahir': instance.tglLahir,
      'jurusan': instance.jurusan,
      'angkatan': instance.angkatan,
      'kelamin': instance.kelamin,
      'agama': instance.agama,
      'golongan_darah': instance.golonganDarah,
      'validated': instance.validated,
      'is_claim': instance.isClaimed,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
