import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_panel/src/models/panel_checkin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'panel_controller.dart';
import 'widgets/main_panel_widget.dart';

class PanelPage extends StatefulWidget {
  const PanelPage({super.key});

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  final controller = Injector.get<PanelController>();

  @override
  void initState() {
    controller.listenerPanel();
    super.initState();
  }

  @override
  void dispose() {
    controller.disposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PanelCheckinModel? current;
    final PanelCheckinModel? lastCall;
    final List<PanelCheckinModel> others;

    final listPanel = controller.panelData.watch(context);

    current = listPanel.firstOrNull;
    if (listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }

    return Scaffold(
      appBar: AppCustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: const MainPanelWidget(
                    passwordLabel: 'Senha Anterior',
                    password: '123456',
                    deskNunber: '123',
                    labelColor: AppTheme.orange,
                    buttonColor: AppTheme.blue,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: const MainPanelWidget(
                    passwordLabel: 'Chamando Senha',
                    password: '123456',
                    deskNunber: '1234',
                    labelColor: AppTheme.blue,
                    buttonColor: AppTheme.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              color: AppTheme.orange,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Últimos chamados',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.orange,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
