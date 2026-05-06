import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nucore_project/data/models/summary_model.dart';
import 'package:nucore_project/data/repositories/admin_repository.dart';

part 'user_dashboard_state.dart';

class UserDashboardCubit extends Cubit<UserDashboardState> {
  UserDashboardCubit() : super(UserDashboardState()) {
    getSummary();
    getRevenue();
  }

  void safeEmit(UserDashboardState state) {
    if (!isClosed) emit(state);
  }

  Future<void> getSummary() async {
    dynamic resp = await AdminRepository.getSummary();

    if (resp is DashboardResponse) {
      safeEmit(state.copyWith(summary: resp));
    }
  }

  void getRevenue() {
    dynamic resp = AdminRepository.getRevenue();
  }
}
