import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nucore_project/core/utils/auth.dart';
import 'package:nucore_project/core/utils/local_storage.dart';
import 'package:nucore_project/core/utils/page_navigator.dart';
import 'package:nucore_project/data/models/login_response_model.dart';
import 'package:nucore_project/data/repositories/auth_repository.dart';
import 'package:nucore_project/presentation/admin_dashboard/admin_dashboard_screen.dart';
import 'package:nucore_project/presentation/user_dashboard/user_dashboard_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'admin@analytics.com');
  final passwordController = TextEditingController(text: 'Admin@123');

  void safeEmit(LoginState state) {
    if (!isClosed) emit(state);
  }

  void isLoading(bool value) => safeEmit(state.copyWith(isLoading: value));

  Future<void> login() async {
    isLoading(true);

    final data = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    dynamic resp = await AuthRepository.login(data);

    if (resp is LoginResponse) {
      await LocalStorage.setData(key: 'access', value: resp.data!.token!);
      String isAdmin = resp.data?.role == "admin" ? "1" : "0";
      await LocalStorage.setData(key: 'isAdmin', value: isAdmin);
      Auth.user = resp.data!.user!;

      if (isAdmin == "1") {
        openAsNewPage(AdminDashboardScreen());
      } else {
        openAsNewPage(UserDashboardScreen());
      }
    }

    isLoading(false);
  }
}
