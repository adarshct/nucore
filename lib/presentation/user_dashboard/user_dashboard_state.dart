part of 'user_dashboard_cubit.dart';

final class UserDashboardState {
  DashboardResponse? summary;

  UserDashboardState({this.summary});

  UserDashboardState copyWith({DashboardResponse? summary}) =>
      UserDashboardState(summary: summary ?? this.summary);
}
