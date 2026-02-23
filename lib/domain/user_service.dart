import 'package:app_registro_perfil/domain/user_model.dart';
import 'package:app_registro_perfil/config/database_config.dart';

class UserService {
  static const String _table = 'usuarios';

  Future<void> add(UserModel user) async {
    final db = await DatabaseConfig.database;
    final map = user.toMap();
    map.remove('id');
    await db.insert(_table, map);
  }

  Future<List<UserModel>> list() async {
    final db = await DatabaseConfig.database;
    final list = await db.query(_table, orderBy: 'id DESC');
    return list.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<UserModel?> getUltimoRegistrado() async {
    final db = await DatabaseConfig.database;
    final list = await db.query(
      _table,
      orderBy: 'id DESC',
      limit: 1,
    );
    if (list.isEmpty) return null;
    return UserModel.fromMap(list.first);
  }
}
