class AuthEntity {
  final String token;
  final User user;

  AuthEntity({required this.token, required this.user});

  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String iss;
  final String azp;
  final String aud;
  final String sub;
  final String hd;
  final String email;
  final bool emailVerified;
  final String name;
  final String picture;
  final String givenName;
  final String familyName;
  final int iat;
  final int exp;

  User({
    required this.iss,
    required this.azp,
    required this.aud,
    required this.sub,
    required this.hd,
    required this.email,
    required this.emailVerified,
    required this.name,
    required this.picture,
    required this.givenName,
    required this.familyName,
    required this.iat,
    required this.exp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      iss: json['iss'],
      azp: json['azp'],
      aud: json['aud'],
      sub: json['sub'],
      hd: json['hd'],
      email: json['email'],
      emailVerified: json['email_verified'],
      name: json['name'],
      picture: json['picture'],
      givenName: json['given_name'],
      familyName: json['family_name'],
      iat: json['iat'],
      exp: json['exp'],
    );
  }
}

class UserEntity {
  final String sub;
  final String name;
  final int exp;

  UserEntity({
    required this.sub,
    required this.name,
    required this.exp,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      sub: json['sub'],
      name: json['name'],
      exp: json['exp'],
    );
  }
}
