import 'package:bloc/bloc.dart';
import 'package:cleopatras_secrets/src/core/dependency_injection.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/advice.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/articles.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/rituals.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/user.dart';

import 'package:cleopatras_secrets/src/feature/rituals/repository/repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Repository userRepository = locator<Repository>();

  UserBloc() : super(const UserLoading()) {
    on<UserLoadData>(_onUserLoadData);
    on<UserUpdateData>(_onUserUpdateData);
  }

  Future<void> _onUserLoadData(
    UserLoadData event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    try {
      List<User> user = await userRepository.load();
      final advice = await userRepository.loadAdvice();
      final rituals = await userRepository.loadRituals();
      final articles = await userRepository.loadArticles();

      if (user.isEmpty) {
        user = [User.init()];
        await userRepository.save(user.first);
      }

      emit(
        UserLoaded(
          user: user.first,
          advice: advice,
          rituals: rituals,
          articles: articles,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при загрузке: $e'));
    }
  }

  Future<void> _onUserUpdateData(
    UserUpdateData event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    try {
      await userRepository.update(event.user);

      final user = await userRepository.load();
      final advice = await userRepository.loadAdvice();
      final rituals = await userRepository.loadRituals();
      final articles = await userRepository.loadArticles();

      emit(
        UserLoaded(
          user: user.first,
          advice: advice,
          rituals: rituals,
          articles: articles,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при обновлении данных: $e'));
    }
  }
}
