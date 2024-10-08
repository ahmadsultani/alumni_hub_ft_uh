import 'package:alumni_hub_ft_uh/features/alumni/domain/models/alumni_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alumni_response.freezed.dart';
part 'alumni_response.g.dart';

@freezed
class AlumniResponse with _$AlumniResponse {
  const factory AlumniResponse({
    required String message,
    required AlumniModel data,
  }) = _AlumniResponse;

  factory AlumniResponse.fromJson(Map<String, dynamic> json) =>
      _$AlumniResponseFromJson(json);
}

@freezed
class AlumniUpdateBody with _$AlumniUpdateBody {
  const factory AlumniUpdateBody({
    String? agama,
    @JsonKey(name: 'no_telp') String? noTelp,
    @JsonKey(name: 'golongan_darah') String? golonganDarah,
  }) = _AlumniUpdateBody;

  factory AlumniUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$AlumniUpdateBodyFromJson(json);
}
