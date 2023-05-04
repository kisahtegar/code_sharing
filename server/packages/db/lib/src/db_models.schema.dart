// ignore_for_file: annotate_overrides

part of 'db_models.dart';

extension DbModelsRepositories on Database {
  UserRepository get users => UserRepository._(this);
}

abstract class UserRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<UserInsertRequest>,
        ModelRepositoryUpdate<UserUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory UserRepository._(Database db) = _UserRepository;

  Future<UserView?> queryUser(int id);
  Future<List<UserView>> queryUsers([QueryParams? params]);
}

class _UserRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<UserInsertRequest>,
        RepositoryUpdateMixin<UserUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements UserRepository {
  _UserRepository(super.db) : super(tableName: 'users', keyName: 'id');

  @override
  Future<UserView?> queryUser(int id) {
    return queryOne(id, UserViewQueryable());
  }

  @override
  Future<List<UserView>> queryUsers([QueryParams? params]) {
    return queryMany(UserViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<UserInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "users" ( "name", "email" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.name)}:text, ${values.add(r.email)}:text )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<UserUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "users"\n'
      'SET "name" = COALESCE(UPDATED."name", "users"."name"), "email" = COALESCE(UPDATED."email", "users"."email")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.name)}:text::text, ${values.add(r.email)}:text::text )').join(', ')} )\n'
      'AS UPDATED("id", "name", "email")\n'
      'WHERE "users"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class UserInsertRequest {
  UserInsertRequest({
    required this.name,
    this.email,
  });

  final String name;
  final String? email;
}

class UserUpdateRequest {
  UserUpdateRequest({
    required this.id,
    this.name,
    this.email,
  });

  final int id;
  final String? name;
  final String? email;
}

class UserViewQueryable extends KeyedViewQueryable<UserView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "users".*'
      'FROM "users"';

  @override
  String get tableAlias => 'users';

  @override
  UserView decode(TypedMap map) =>
      UserView(id: map.get('id'), name: map.get('name'), email: map.getOpt('email'));
}

class UserView {
  UserView({
    required this.id,
    required this.name,
    this.email,
  });

  final int id;
  final String name;
  final String? email;
}
