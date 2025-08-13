import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmitted(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {
  final String error;
  const LoginFailure(this.error);
  @override
  List<Object> get props => [error];
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(event.email);
      final passwordValid = event.password.length >= 8 &&
          RegExp(r'[A-Z]').hasMatch(event.password) &&
          RegExp(r'[a-z]').hasMatch(event.password) &&
          RegExp(r'[0-9]').hasMatch(event.password) &&
          RegExp(r'[^A-Za-z0-9]').hasMatch(event.password);

      if (emailValid && passwordValid) {
        await Future.delayed(const Duration(seconds: 1));
        emit(LoginSuccess());
      } else {
        emit(const LoginFailure('Invalid email or password format'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}