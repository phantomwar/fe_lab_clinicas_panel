import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_panel/src/bindings/core_app_binding.dart';
import 'package:fe_lab_clinicas_panel/src/pages/login/login_router.dart';
import 'package:fe_lab_clinicas_panel/src/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'src/pages/panel/panel_router.dart';

void main() {
  runApp(const LabClibnicasPanelApp());
}

class LabClibnicasPanelApp extends StatelessWidget {
  const LabClibnicasPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      title: 'Lab Clinicas Panel',
      bindings: CoreAppBinding(),
      pagesBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/')
      ],
      pages: const [
        LoginRouter(),
        PanelRouter(),
      ],
    );
  }
}
