import 'package:db/db.dart' as db;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@Freezed()
class User with _$User implements db.UserView {
  const factory User({
    required int id,
    required String name,
    @Default("") String email,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  factory User.fromDb(db.UserView dbUser) => User(
        id: dbUser.id,
        name: dbUser.name,
        email: dbUser.email!,
      );
}
