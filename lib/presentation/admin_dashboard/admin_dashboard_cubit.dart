import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nucore_project/core/utils/page_navigator.dart';
import 'package:nucore_project/data/models/login_response_model.dart';
import 'package:nucore_project/data/repositories/admin_repository.dart';

part 'admin_dashboard_state.dart';

class AdminDashboardCubit extends Cubit<AdminDashboardState> {
  AdminDashboardCubit() : super(AdminDashboardState()) {
    getUsers();
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void safeEmit(AdminDashboardState state) {
    if (!isClosed) emit(state);
  }

  void isLoading(bool value) => safeEmit(state.copyWith(isLoading: value));

  Future<void> getUsers() async {
    isLoading(true);

    dynamic resp = await AdminRepository.getUsers();

    if (resp is List<User>) {
      safeEmit(state.copyWith(users: resp));
    }

    isLoading(false);
  }

  Future<void> createUser({String? id}) async {
    final data = {
      'email': emailController.text,
      'name': nameController.text,
      'password': passwordController.text,
      'role': state.role,
    };

    dynamic resp = await AdminRepository.createUser(data: data, id: id);

    if (resp == true) {
      closePage();
      await getUsers();
    }
  }

  void swapRole(String role) => safeEmit(state.copyWith(role: role));

  // Future<void> updateUser() async {
  //   final data = {
  //     'email': emailController.text,
  //     'name': nameController.text,
  //     'password': passwordController.text,
  //     'role': state.role,
  //   };

  //   dynamic resp = await AdminRepository.createUser(data);

  //   if (resp == true) {
  //     await getUsers();
  //   }
  // }
}
