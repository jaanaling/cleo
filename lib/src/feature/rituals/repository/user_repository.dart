import 'package:cleopatras_secrets/src/feature/rituals/model/chicken_catalog.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/coop.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/tasks.dart';

import '../../../core/utils/json_loader.dart';

class Repository {
  final String chickens = 'chickens';
  final String tasks = 'tasks';
  final String coops = 'coop';

  Future<List<Coop>> load() {
    return JsonLoader.loadData<Coop>(
      coops,
      'assets/json/$coops.json',
      (json) => Coop.fromMap(json),
    );
  }

  Future<List<ChickenCatalog>> loadChicken() {
    return JsonLoader.loadData<ChickenCatalog>(
      chickens,
      'assets/json/$chickens.json',
      (json) => ChickenCatalog.fromMap(json),
    );
  }

  Future<List<TaskCatalog>> loadTask() {
    return JsonLoader.loadData<TaskCatalog>(
      tasks,
      'assets/json/$tasks.json',
      (json) => TaskCatalog.fromMap(json),
    );
  }

  Future<void> update(Coop updated) async {
    return JsonLoader.modifyDataList<Coop>(
      coops,
      updated,
      () async => await load(),
      (item) => item.toMap(),
      (itemList) async {
        final index = itemList.indexWhere((d) => d.id == updated.id);
        if (index != -1) {
          itemList[index] = updated;
        }
      },
    );
  }

  Future<void> save(Coop item) {
    return JsonLoader.saveData<Coop>(
      coops,
      item,
      () async => await load(),
      (item) => item.toMap(),
    );
  }

  Future<void> remove(Coop item) {
    return JsonLoader.removeData<Coop>(
      coops,
      item,
      () async => await load(),
      (item) => item.toMap(),
    );
  }
}
