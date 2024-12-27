import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Events
abstract class AuthEvent {}

class SignUpWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  SignUpWithEmailEvent(this.email, this.password);
}

class SignInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  SignInWithEmailEvent(this.email, this.password);
}

class SignInWithGoogleEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class Authenticated extends AuthState {
  final User user;
  Authenticated(this.user);
}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
class Unauthenticated extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthService();

  AuthBloc() : super(AuthInitial()) {
    // Handle Email Sign Up
    on<SignUpWithEmailEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await _authService.signUpWithEmail(
          event.email,
          event.password,
        );
        emit(Authenticated(result.user!));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // Handle Email Sign In
    on<SignInWithEmailEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await _authService.signInWithEmail(
          event.email,
          event.password,
        );
        emit(Authenticated(result.user!));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // Handle Google Sign In
    on<SignInWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await _authService.signInWithGoogle();
        if (result?.user != null) {
          emit(Authenticated(result!.user!));
        } else {
          emit(AuthError('Google sign in failed'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // Handle Sign Out
    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      await _authService.signOut();
      emit(Unauthenticated());
    });
  }
}