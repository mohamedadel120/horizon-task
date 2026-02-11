import 'package:task/core/base/cubit/base_state.dart';

class AuthState extends BaseState {
  const AuthState({super.apiStates});

  @override
  AuthState copyWith({Map<String, BaseApiState>? apiStates}) {
    return AuthState(apiStates: apiStates ?? this.apiStates);
  }
}
