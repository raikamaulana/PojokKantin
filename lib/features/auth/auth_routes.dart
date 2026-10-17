import 'package:flutter/material.dart';
import 'package:pojokkantin/features/auth/edit_profil_page.dart';
import 'package:pojokkantin/features/auth/profil_page.dart';
import '../../core/route_names.dart';
import 'splash_page.dart';
import 'onboarding_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'data_diri_page.dart';

class AuthRoutes {
  AuthRoutes._();

  static Map<String, WidgetBuilder> get routes => {
    AppRoutes.splash: (context) => const SplashPage(),

    AppRoutes.onboarding: (context) => const OnboardingPage(),

    AppRoutes.login: (context) => const LoginPage(),

    AppRoutes.register: (context) => const RegisterPage(),

    AppRoutes.registerDataDiri: (context) => const DataDiriPage(),

    AppRoutes.profil: (context) => const ProfilPage(),

    AppRoutes.profilEdit: (context) => const EditProfilPage(),
  };
}
