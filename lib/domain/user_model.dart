class UserModel {
  UserModel({
    this.id,
    this.cedula,
    required this.name,
    this.email,
    this.phone,
    this.cumpleanos,
    this.genero,
    this.createdAt,
  });

  final int? id;
  final String? cedula;
  final String name;
  final String? email;
  final String? phone;
  final String? cumpleanos;
  final String? genero;
  final String? createdAt;

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'cedula': cedula,
      'name': name,
      'email': email,
      'phone': phone,
      'fecha_nacimiento': cumpleanos,
      'genero': genero,
      'created_at': createdAt,
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
      genero: map['genero'] as String?,
      createdAt: map['created_at'] as String?,
    );
  }

  UserModel copyWith({
    int? id,
    String? cedula,
    String? name,
    String? email,
    String? phone,
    String? cumpleanos,
    String? genero,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      cedula: cedula ?? this.cedula,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      cumpleanos: cumpleanos ?? this.cumpleanos,
      genero: genero ?? this.genero,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
