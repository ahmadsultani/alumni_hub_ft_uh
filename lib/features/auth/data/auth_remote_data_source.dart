import 'package:alumni_hub_ft_uh/data/api.dart';
import 'package:alumni_hub_ft_uh/features/auth/domain/auth_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthRemoteDataSource {
  final Api _api;

  AuthRemoteDataSource(this._api);

  Future<SignInResponse> signIn(SignInBody body) async {
    final response = await _api.createApiCall(
      endpoint: '/auth/login',
      method: NetworkCallMethod.post,
      body: body.toJson(),
    );
    return SignInResponse.fromJson(response.data);
  }

  Future<SignUpResponse> signUp(SignUpBody body) async {
    final response = await _api.createApiCall(
      endpoint: '/auth/register',
      method: NetworkCallMethod.post,
      body: body.toJson(),
    );
    return SignUpResponse.fromJson(response.data);
  }

  Future<void> signOut() async {
    await _api.createApiCall(
      endpoint: '/auth/signout',
      method: NetworkCallMethod.post,
    );
  }

  Future<SignInWithGoogleResponse> signInWithGoogle(String accessToken) async {
    final response = await _api.createApiCall(
      endpoint: '/auth/google',
      method: NetworkCallMethod.post,
      body: {'access_token_client': accessToken},
    );
    return SignInWithGoogleResponse.fromJson(response.data);
  }
}
