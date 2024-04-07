library otter;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:otter/core/task_handler.dart';
import 'package:otter/manager/database_manager.dart';
import 'package:otter/core/task_processor.dart';
import 'package:synchronized/synchronized.dart';

class OTNetworkManager {
  final OTDatabaseManager _databaseManager = OTDatabaseManager();

  final OTTaskHandler _handler;

  OTNetworkManager(this._handler);

  Future<void> observe() async {
    var lock = Lock(reentrant: true);

    Connectivity().onConnectivityChanged.listen((event) async {
      if (event.first != ConnectivityResult.none) {
        await lock.synchronized(() async {
          final tasks = await _databaseManager.getTasks();

          if (tasks.isNotEmpty) {
            await OTTaskProcessor().executeMultipleTasks(tasks, _handler,
                offlineStorageEnabled: false);
          }
        });
      }
    });
  }
}
