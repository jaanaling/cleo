part of 'user_bloc.dart';

abstract class UserEvent {}

class UserLoadData extends UserEvent {}

class UserUpdateData extends UserEvent {
  final User user;
  UserUpdateData({
    required this.user,
  });
}
