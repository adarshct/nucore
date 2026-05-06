part of 'login_cubit.dart';

final class LoginState {
  bool isLoading;

  LoginState({this.isLoading = false});

  LoginState copyWith({bool? isLoading = false}) =>
      LoginState(isLoading: isLoading ?? this.isLoading);
}
