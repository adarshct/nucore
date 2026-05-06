import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future open<T extends StateStreamableSource>(
  Widget page, {
  BuildContext? context,
}) {
  return Navigator.push(
    context ?? NavigationService.context!,
    MaterialPageRoute(
      builder: (_) {
        try {
          return BlocProvider.value(value: context!.read<T>(), child: page);
        } catch (_) {
          return page;
        }
      },
    ),
  );
}

Future openClosingCurrent<T extends StateStreamableSource>(
  Widget page, {
  BuildContext? context,
}) {
  return Navigator.pushReplacement(
    context ?? NavigationService.context!,
    MaterialPageRoute(
      builder: (_) {
        try {
          return BlocProvider.value(value: context!.read<T>(), child: page);
        } catch (_) {
          return page;
        }
      },
    ),
  );
}

Future openAsNewPage(Widget page, {BuildContext? context}) =>
    Navigator.pushAndRemoveUntil(
      context ?? NavigationService.context!,
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );

void closePage({dynamic result}) =>
    Navigator.pop(NavigationService.context!, result);

void closeDialog({dynamic result}) =>
    Navigator.of(NavigationService.context!, rootNavigator: true).pop(result);

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;
}
