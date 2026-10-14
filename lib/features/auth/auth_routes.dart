import 'package:flutter/material.dart';
import '../../core/route_names.dart';
import '../../shared/placeholder_page.dart';

class AuthRoutes {
  AuthRoutes._();

  static Map<String, WidgetBuilder> get routes => {
    AppRoutes.splash: (context) => const PlaceholderPage(
      title: 'Splash',
    ),

    AppRoutes.onboarding: (context) => const PlaceholderPage(
      title: 'Onboarding',
    ),

    AppRoutes.login: (context) => const PlaceholderPage(
      title: 'Login',
    ),

    AppRoutes.register: (context) => const PlaceholderPage(
      title: 'Register',
    ),

    AppRoutes.registerDataDiri: (context) => const PlaceholderPage(
      title: 'Form Data Diri',
    ),

    AppRoutes.profil: (context) => const PlaceholderPage(
      title: 'Profil Saya',
    ),

    AppRoutes.profilEdit: (context) => const PlaceholderPage(
      title: 'Edit Profil',
    ),
  };
}