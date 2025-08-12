import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class LoginState {
  final bool isValid;
  final String errorMessage;

  LoginState({required this.isValid, this.errorMessage = ''});
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(isValid: false));

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    final emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(event.email);
    final passwordValid = event.password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(event.password) &&
        RegExp(r'[a-z]').hasMatch(event.password) &&
        RegExp(r'[0-9]').hasMatch(event.password) &&
        RegExp(r'[!@#\$&*~]').hasMatch(event.password);

    if (emailValid && passwordValid) {
      yield LoginState(isValid: true);
    } else {
      yield LoginState(isValid: false, errorMessage: 'Invalid credentials');
    }
  }
}