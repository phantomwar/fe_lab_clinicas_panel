import 'package:fe_lab_clinicas_panel/src/repositories/panel_checkin/panel_checkin_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import '../../repositories/panel_checkin/panel_checkin_repository_impl.dart';
import 'panel_controller.dart';
import 'panel_page.dart';

class PanelRouter extends FlutterGetItPageRouter {
  const PanelRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<PanelCheckinRepository>(
            (i) => PanelCheckinRepositoryImpl(
                  restClient: i(),
                )),
        Bind.lazySingleton((i) => PanelController(repository: i()))
      ];

  @override
  String get routeName => '/panel';

  @override
  WidgetBuilder get view => (_) => const PanelPage();
}
