part of 'admin_dashboard_cubit.dart';

final class AdminDashboardState {
  List<User> users;
  bool isLoading;
  String role;

  AdminDashboardState({
    this.users = const [],
    this.isLoading = false,
    this.role = "user",
  });

  AdminDashboardState copyWith({
    List<User>? users,
    bool? isLoading,
    String? role,
  }) => AdminDashboardState(
    users: users ?? this.users,
    isLoading: isLoading ?? this.isLoading,
    role: role ?? this.role,
  );
}
