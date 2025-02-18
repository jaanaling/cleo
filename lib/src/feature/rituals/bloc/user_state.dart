part of 'user_bloc.dart';

abstract class UserState {
  const UserState();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final User user;
  final List<Advice> advice;
  final List<Rituals> rituals;
  final List<Articles> articles;

  const UserLoaded({
    required this.user,
    required this.advice,
    required this.rituals,
    required this.articles,
  });
}

class UserError extends UserState {
  final String message;
  const UserError(this.message);
}
