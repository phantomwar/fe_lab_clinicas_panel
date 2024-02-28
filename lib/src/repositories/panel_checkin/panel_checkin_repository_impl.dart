import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_panel/src/models/panel_checkin_model.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../core/env.dart';
import './panel_checkin_repository.dart';

class PanelCheckinRepositoryImpl implements PanelCheckinRepository {
  final RestClient restClient;

  PanelCheckinRepositoryImpl({required this.restClient});

  @override
  Stream<List<PanelCheckinModel>> getTodayPanel(
      WebSocketChannel channel) async* {
    yield await requestData();
    yield* channel.stream.asyncMap((_) => requestData());
  }

  @override
  ({WebSocketChannel channel, Function dispose}) openChannelSocket() {
    final channel = WebSocketChannel.connect(
        Uri.parse('${Env.wsBackendBaseUrl}?tables=painelCheckin'));

    return (
      channel: channel,
      dispose: () {
        channel.sink.close();
      }
    );
  }

  Future<List<PanelCheckinModel>> requestData() async {
    final dateFormat = DateFormat('y-MM-d');
    final Response(:List data) =
        await restClient.auth.get('/painelCheckin', queryParameters: {
      'time_called': dateFormat.format(DateTime.now()),
    });

    return data.reversed
        .take(7)
        .map((e) => PanelCheckinModel.fromJson(e))
        .toList();
  }
}
