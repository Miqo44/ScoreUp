class LoginUtils {
  static void handleLogin(
      {required String username,
        required String password,
        required String? registeredUsername,
        required String? registeredPassword,
        required Function onLoginSuccess,
        required Function onLoginFailure,
        required Function onDisableLoginButton}) {
    if (registeredUsername != null && registeredPassword != null) {
      if (username == registeredUsername && password == registeredPassword) {
        onLoginSuccess();
      } else {
        onLoginFailure();
        onDisableLoginButton();
      }
    } else {
      onLoginFailure();
    }
  }
}
