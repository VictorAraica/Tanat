class UserApp {
  UserApp({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.phone,
    this.identification,
    this.identificationType,
    this.emailIsVerified,
    this.createdAt,
    this.updatedAt,
    this.identificationIsVerified,
  });

  UserApp.fromJson(dynamic json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    identification = json['identification'];
    identificationType = json['identificationType'];
    emailIsVerified = json['emailIsVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    identificationIsVerified = json['identificationIsVerified'] ?? false;
  }

  String? id;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? phone;
  String? identification;
  String? identificationType;
  bool? emailIsVerified;
  String? createdAt;
  String? updatedAt;
  bool? identificationIsVerified;

  UserApp copyWith({
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    String? phone,
    String? identification,
    String? identificationType,
    bool? emailIsVerified,
    String? createdAt,
    String? updatedAt,
  }) => UserApp(
    firstname: firstname ?? this.firstname,
    lastname: lastname ?? this.lastname,
    username: username ?? this.username,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    identification: identification ?? this.identification,
    identificationType: identificationType ?? this.identificationType,
    emailIsVerified: emailIsVerified ?? this.emailIsVerified,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['username'] = username;
    map['email'] = email;
    map['phone'] = phone;
    map['identification'] = identification;
    map['identificationType'] = identificationType;
    map['emailIsVerified'] = emailIsVerified;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['identificationIsVerified'] = identificationIsVerified;
    return map;
  }
}
