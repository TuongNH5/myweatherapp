///Created by Nguyen Huu Tuong on 09/11/2023.
abstract class AppState {}

class LoadingState extends AppState {}

class DoneState extends AppState {}

class ErrorState extends AppState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}