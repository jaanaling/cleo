import 'package:bloc/bloc.dart';
import 'package:cleopatras_secrets/src/core/dependency_injection.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/chicken_catalog.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/coop.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/tasks.dart';
import 'package:cleopatras_secrets/src/feature/rituals/repository/user_repository.dart';


part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Repository userRepository = locator<Repository>();

  UserBloc() : super(const UserLoading()) {
    on<UserLoadData>(_onUserLoadData);
    on<CompleteTaskEvent>(_onCompleteTaskEvent);
    on<CreateCoopEvent>(_onCreateCoopEvent);
    on<UpdateCoopEvent>(_onUpdateCoopEvent);
    on<RemoveCoopEvent>(_onRemoveCoopEvent);
  }

  Future<void> _onUserLoadData(
    UserLoadData event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    try {
      final coops = await userRepository.load();
      final chickens = await userRepository.loadChicken();
      final tasks = await userRepository.loadTask();

      coops.forEach((action) async {
        action.tasks.forEach((a) => action.checkTask(a.id));
        await userRepository.update(action);
      });

      final checkedCoops = await userRepository.load();

      emit(
        UserLoaded(
          coops: checkedCoops,
          chickens: chickens,
          tasks: tasks,
        ),
      );
    } catch (e) {
      emit(UserError('Произошла ошибка при загрузке: $e'));
    }
  }

  Future<void> _onCompleteTaskEvent(
    CompleteTaskEvent event,
    Emitter<UserState> emit,
  ) async {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      try {
        final updatedCoops = currentState.coops.map((coop) {
          if (coop.id == event.coopId) {
            return coop.completeTask(event.taskId);
          }
          return coop;
        }).toList();

        emit(
          UserLoaded(
            coops: updatedCoops,
            chickens: currentState.chickens,
            tasks: currentState.tasks,
          ),
        );
      } catch (e) {
        emit(UserError('Ошибка при выполнении задания: $e'));
      }
    }
  }

  Future<void> _onCreateCoopEvent(
    CreateCoopEvent event,
    Emitter<UserState> emit,
  ) async {
    if (state is UserLoaded) {
      try {
        final currentState = state as UserLoaded;
        // Берем "новый курятник"
        var newCoop = event.newCoop;

        // Добавляем в этот курятник ВСЕ задачи из каталога
        // (если нужно, копию каждого TaskCatalog)
        // newCoop у нас, скорее всего, будет иметь поле List<TaskCatalog> tasks;
        newCoop = newCoop.copyWith(
          tasks: currentState.tasks, // текущий "каталог" из UserLoaded
        );

        // Теперь сохраняем этот курятник (репозиторий)
        await userRepository.save(newCoop);

        // Перезагружаем список курятников
        final coops = await userRepository.load();

        // Оставляем tasks и chickens, как раньше
        emit(
          UserLoaded(
            coops: coops,
            chickens: currentState.chickens,
            tasks: currentState.tasks,
          ),
        );
      } catch (e) {
        emit(UserError('Ошибка при создании курятника: $e'));
      }
    }
  }

  /// Обновить существующий курятник
  Future<void> _onUpdateCoopEvent(
    UpdateCoopEvent event,
    Emitter<UserState> emit,
  ) async {
    if (state is UserLoaded) {
      emit(const UserLoading());
      try {
        // Вызываем метод update в репозитории
        await userRepository.update(event.coopToUpdate);

        // После обновления — перезагружаем данные (или локально обновляем список)
        final coops = await userRepository.load();
        final chickens = await userRepository.loadChicken();
        final tasks = await userRepository.loadTask();

        emit(UserLoaded(coops: coops, chickens: chickens, tasks: tasks));
      } catch (e) {
        emit(UserError('Ошибка при обновлении курятника: $e'));
      }
    }
  }

  Future<void> _onRemoveCoopEvent(
    RemoveCoopEvent event,
    Emitter<UserState> emit,
  ) async {
    if (state is UserLoaded) {
      emit(const UserLoading());
      try {
        await userRepository.remove(event.coopToRemove);
        final coops = await userRepository.load();
        final chickens = await userRepository.loadChicken();
        final tasks = await userRepository.loadTask();
        emit(UserLoaded(coops: coops, chickens: chickens, tasks: tasks));
      } catch (e) {
        emit(UserError('Ошибка при удалении курятника: $e'));
      }
    }
  }

}
