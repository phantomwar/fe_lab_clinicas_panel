import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_panel/src/models/panel_checkin_model.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../repositories/panel_checkin/panel_checkin_repository.dart';

class PanelController with MessageStateMixin {
  PanelController({
    required PanelCheckinRepository repository,
  }) : _repository = repository;

  final PanelCheckinRepository _repository;
  final panelData = listSignal<PanelCheckinModel>([]);

  Connect? _panelConnect;

  Function? _socketDispose;

  void listenerPanel() {
    final (:channel, :dispose) = _repository.openChannelSocket();
    _socketDispose = dispose;

    _panelConnect = connect(panelData);
    final panelStream = _repository.getTodayPanel(channel);
    _panelConnect!.from(panelStream);
  }

  void disposed() {
    _panelConnect?.dispose();
    if (_socketDispose != null) {
      _socketDispose!();
    }
  }
}
