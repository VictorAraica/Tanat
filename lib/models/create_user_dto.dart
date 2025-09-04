class CreateUserDto {
  CreateUserDto({
    this.firstname,
    this.lastname,
    this.username,
    this.identification,
    this.identificationType,
    this.phone,
    this.password,
    this.email,
  });

  CreateUserDto.fromJson(dynamic json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    identification = json['identification'];
    identificationType = json['identificationType'];
    phone = json['phone'];
    password = json['password'];
    email = json['email'];
  }
  String? firstname;
  String? lastname;
  String? username;
  String? identification;
  String? identificationType;
  String? phone;
  String? password;
  String? email;
  CreateUserDto copyWith({
    String? firstname,
    String? lastname,
    String? username,
    String? identification,
    String? identificationType,
    String? phone,
    String? password,
    String? email,
  }) => CreateUserDto(
    firstname: firstname ?? this.firstname,
    lastname: lastname ?? this.lastname,
    username: username ?? this.username,
    identification: identification ?? this.identification,
    identificationType: identificationType ?? this.identificationType,
    phone: phone ?? this.phone,
    password: password ?? this.password,
    email: email ?? this.email,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['username'] = username;
    map['identification'] = identification;
    map['identificationType'] = identificationType;
    map['phone'] = phone;
    map['password'] = password;
    map['email'] = email;

    return map;
  }
}
