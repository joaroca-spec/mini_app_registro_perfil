class UserModel {
  UserModel({
    this.id,
    this.cedula,
    required this.name,
    this.email,
    this.phone,
    this.cumpleanos,
    this.avatarUrl,
  });

  final int? id;
  final String? cedula;
  final String name;
  final String? email;
  final String? phone;
  final String? cumpleanos;
  final String? avatarUrl;

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'cedula': cedula,
      'name': name,
      'email': email,
      'phone': phone,
      'fecha_nacimiento': cumpleanos,
      'avatar_url': avatarUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      cedula: map['cedula'] as String?,
      name: map['name'] as String,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      cumpleanos: map['fecha_nacimiento'] as String?,
      avatarUrl: map['avatar_url'] as String?,
    );
  }

  UserModel copyWith({
    int? id,
    String? cedula,
    String? name,
    String? email,
    String? phone,
    String? cumpleanos,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      cedula: cedula ?? this.cedula,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      cumpleanos: cumpleanos ?? this.cumpleanos,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
