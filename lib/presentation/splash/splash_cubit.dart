import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nucore_project/core/utils/auth.dart';
import 'package:nucore_project/core/utils/page_navigator.dart';
import 'package:nucore_project/presentation/admin_dashboard/admin_dashboard_screen.dart';
import 'package:nucore_project/presentation/login/login_screen.dart';
import 'package:nucore_project/presentation/user_dashboard/user_dashboard_screen.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState()) {
    intialNavigation();
  }

  void intialNavigation() {
    Future.delayed(Duration(seconds: 3), () async {
      if (Auth.accessToken.isEmpty) {
        openAsNewPage(LoginScreen());
      } else {
        if (Auth.isAdmin == "1") {
          openAsNewPage(AdminDashboardScreen());
        } else if (Auth.isAdmin == "0") {
          openAsNewPage(UserDashboardScreen());
        } else {
          openAsNewPage(LoginScreen());
        }
      }
    });
  }
}
