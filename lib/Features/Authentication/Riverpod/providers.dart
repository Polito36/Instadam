import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instadam_firebase/Features/Authentication/Riverpod/state_notifier_provider.dart';
import '../Services/auth_service.dart';

final authServiceProvider = Provider((ref) {
  return AuthService();
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier(ref.watch(authServiceProvider));
});

final authStateProvider = StreamProvider((ref) {
  final authState = ref.watch(authServiceProvider);

  return authState.authStateChanges;
});
