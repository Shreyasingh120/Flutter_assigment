import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String password;

  LoginSubmitted(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

// States
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// BLoC
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
      // Add your authentication logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}