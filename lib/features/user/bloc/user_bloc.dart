import 'dart:convert';

import 'package:alumni_hub_ft_uh/common/utils/app_navigation.dart';
import 'package:alumni_hub_ft_uh/constants/keys.dart';
import 'package:alumni_hub_ft_uh/features/auth/domain/auth_repository.dart';
import 'package:alumni_hub_ft_uh/features/user/bloc/user_event.dart';
import 'package:alumni_hub_ft_uh/features/user/bloc/user_state.dart';
import 'package:alumni_hub_ft_uh/features/user/domain/models/user_model.dart';
import 'package:alumni_hub_ft_uh/features/user/domain/user_repository.dart';
import 'package:alumni_hub_ft_uh/locator.dart';
import 'package:alumni_hub_ft_uh/middleware/custom_exception.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  UserBloc(this._userRepository, this._authRepository) : super(UserInitial()) {
    on<UserEventSignIn>((event, emit) async {
      emit(UserStateSignInLoading());
      try {
        final signInResponse = await _authRepository.signIn(event.signInBody);
        _userRepository.saveUserSession(
            UserSession(token: signInResponse.token, user: null));
        final user = await _userRepository.getProfile();
        _userRepository.saveUserSession(
            UserSession(token: signInResponse.token, user: user.data));
        emit(UserStateSuccessSignIn(signInResponse));
      } on CustomException catch (e) {
        emit(UserStateException(e));
      }
    });

    on<UserEventSignUp>((event, emit) async {
      emit(UserStateSignUpLoading());
      try {
        final signUpResponse = await _authRepository.signUp(event.signUpBody);
        _userRepository.saveUserSession(
            UserSession(token: signUpResponse.token, user: null));
        final user = await _userRepository.getProfile();
        _userRepository.saveUserSession(
            UserSession(token: signUpResponse.token, user: user.data));
        emit(UserStateSuccessSignUp(signUpResponse));
      } on CustomException catch (e) {
        emit(UserStateException(e));
      }
    });

    on<UserEventGetProfile>((event, emit) async {
      emit(UserStateGetProfileLoading());
      try {
        final user = await _userRepository.getProfile();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final userSession =
            UserSession.fromJson(json.decode(prefs.getString(kUserSession)!));
        _userRepository.saveUserSession(
            UserSession(token: userSession.token, user: user.data));
        emit(UserStateSuccessGetProfile(user));
      } on CustomException catch (e) {
        emit(UserStateException(e));
      }
    });

    on<UserEventSignOut>((event, emit) async {
      emit(UserStateSignOutLoading());
      try {
        await signOut();
      } on CustomException catch (e) {
        emit(UserStateException(e));
      } finally {
        await _userRepository.deleteUserSession();
        emit(UserStateSuccessSignOut());
      }
    });

    on<UserEventSignInWithGoogle>((event, emit) async {
      emit(UserStateSignInWithGoogleLoading());
      try {
        final googleResponse = await _authRepository.signInWithGoogle();
        _userRepository.saveUserSession(UserSession(
          token: googleResponse.token,
          user: googleResponse.data,
        ));
        emit(UserStateSuccessSignInWithGoogle(googleResponse));
      } on CustomException catch (e) {
        emit(UserStateException(e));
      }
    });

    on<UserEventDeleteUser>((event, emit) async {
      emit(UserStateDeleteUserLoading());
      try {
        await _userRepository.deleteUser();
        await signOut();
        emit(UserStateSuccessDeleteUser());
      } on CustomException catch (e) {
        emit(UserStateException(e));
      }
    });
  }

  UserSession? getUserSession() => _userRepository.getUserSession();

  Future<void> signOut() async {
    await clearUserSession();
    locator<AppNavigation>().navigateReplace('/sign_in');
  }

  Future<bool> clearUserSession() => _userRepository.deleteUserSession();
}
