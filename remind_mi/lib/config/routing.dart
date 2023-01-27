import 'package:go_router/go_router.dart';
import 'package:remind_mi/pages/auth_page.dart';
import 'package:remind_mi/pages/calendar_page.dart';
import 'package:remind_mi/pages/config_page.dart';
import 'package:remind_mi/pages/forgot_pwd_page.dart';
import 'package:remind_mi/pages/form_page.dart';
import 'package:remind_mi/pages/main_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
        path: "/",
        name: "home",
        builder: (context, state) => const MainPage(),
        routes: [
          GoRoute(
            name: "auth",
            path: "auth",
            builder: (context, state) => const AuthPage(),
          ),
          GoRoute(
            name: "reset",
            path: "reset",
            builder: (context, state) => const ForgotPasswordPage(),
          ),
          GoRoute(
            name: "calendar",
            path: "calendar",
            builder: (context, state) => const CalendarPage(),
          ),
          GoRoute(
            name: "config",
            path: "parameters",
            builder: (context, state) => const ConfigPage(),
          )
        ]),
  ],
);
