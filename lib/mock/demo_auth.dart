class DemoUser {
  final String fullName;
  final String username;
  final String email;
  final String password;

  const DemoUser({
    required this.fullName,
    required this.username,
    required this.email,
    required this.password,
  });
}

enum DemoLoginStatus {
  success,
  userNotFound,
  wrongPassword,
}

class DemoLoginResult {
  final DemoLoginStatus status;
  final DemoUser? user;

  const DemoLoginResult({
    required this.status,
    this.user,
  });
}

class DemoAuth {
  DemoAuth._();

  static final List<DemoUser> _users = [
    const DemoUser(
      fullName: 'Pepito Perez',
      username: 'Pepito Perez',
      email: 'pepito@email.com',
      password: '12345',
    ),
  ];

  static DemoUser? currentUser;

  static DemoLoginResult login({
    required String username,
    required String password,
  }) {
    final normalizedUsername = username.trim().toLowerCase();

    DemoUser? foundUser;
    try {
      foundUser = _users.firstWhere(
        (item) =>
            item.username.toLowerCase() == normalizedUsername ||
            item.email.toLowerCase() == normalizedUsername,
      );
    } catch (_) {
      return const DemoLoginResult(status: DemoLoginStatus.userNotFound);
    }

    if (foundUser.password != password) {
      return const DemoLoginResult(status: DemoLoginStatus.wrongPassword);
    }

    currentUser = foundUser;
    return DemoLoginResult(
      status: DemoLoginStatus.success,
      user: foundUser,
    );
  }

  static void logout() {
    currentUser = null;
  }

  static String? register({
    required String fullName,
    required String email,
    required String password,
  }) {
    final normalizedName = fullName.trim();
    final normalizedEmail = email.trim().toLowerCase();

    final nameExists = _users.any(
      (item) => item.username.toLowerCase() == normalizedName.toLowerCase(),
    );
    if (nameExists) {
      return 'Ya existe un usuario con ese nombre';
    }

    final emailExists = _users.any(
      (item) => item.email.toLowerCase() == normalizedEmail,
    );
    if (emailExists) {
      return 'Ese correo ya esta registrado';
    }

    final user = DemoUser(
      fullName: normalizedName,
      username: normalizedName,
      email: normalizedEmail,
      password: password,
    );
    _users.add(user);
    currentUser = user;
    return null;
  }

  static String get currentDisplayName => currentUser?.fullName ?? 'Invitado';
}
