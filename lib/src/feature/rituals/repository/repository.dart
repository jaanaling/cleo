import 'package:cleopatras_secrets/src/feature/rituals/model/advice.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/articles.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/rituals.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/user.dart';

import '../../../core/utils/json_loader.dart';

class Repository {
  final String user = 'user';
  final String advice = 'advice';
  final String rituals = 'rituals';
  final String articles = 'articles';

  Future<List<User>> load() {
    return JsonLoader.loadData<User>(
      user,
      'assets/json/$user.json',
      (json) => User.fromMap(json),
    );
  }

  Future<List<Advice>> loadAdvice() {
    return JsonLoader.loadData<Advice>(
      advice,
      'assets/json/$advice.json',
      (json) => Advice.fromMap(json),
    );
  }

  Future<List<Articles>> loadArticles() {
    return JsonLoader.loadData<Articles>(
      articles,
      'assets/json/$articles.json',
      (json) => Articles.fromMap(json),
    );
  }

  Future<List<Rituals>> loadRituals() {
    return JsonLoader.loadData<Rituals>(
      rituals,
      'assets/json/$rituals.json',
      (json) => Rituals.fromMap(json),
    );
  }

  Future<void> update(User updated) async {
    return JsonLoader.modifyDataList<User>(
      user,
      updated,
      () async => await load(),
      (item) => item.toMap(),
      (itemList) async {
        final index = 0;
        if (index != -1) {
          itemList[index] = updated;
        }
      },
    );
  }
}
