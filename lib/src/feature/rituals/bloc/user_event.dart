part of 'user_bloc.dart';

abstract class UserEvent {}

class UserLoadData extends UserEvent {}

class CompleteTaskEvent extends UserEvent {
  final String coopId;
  final String taskId;
  CompleteTaskEvent({required this.coopId, required this.taskId});
}

class CreateCoopEvent extends UserEvent {
  final Coop newCoop;
  CreateCoopEvent({
    required this.newCoop,
  });
}

/// Обновление существующего курятника
class UpdateCoopEvent extends UserEvent {
  final Coop coopToUpdate;
  UpdateCoopEvent({
    required this.coopToUpdate,
  });
}

class RemoveCoopEvent extends UserEvent {
  final Coop coopToRemove;
  RemoveCoopEvent({required this.coopToRemove});
}
