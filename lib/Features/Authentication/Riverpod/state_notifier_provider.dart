import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../Services/auth_service.dart';

class AuthNotifier extends StateNotifier<bool> {
  final AuthService _authService;
  AuthNotifier(this._authService) : super(false);

  Future<void> logOut() async {
    await _authService.logout();
    state = true;
  }

  Future<void> signUpWithEmailPassword(
      String email, String password, String userName) async {
    await _authService.signUpWithEmailPassword(email, password, userName);
    state = true;
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    await _authService.signInWithEmailPassword(email, password);
    state = true;
  }

  Future<void> googleSignIn() async {
    await _authService.googleSignIn();
    state = true;
  }
}
