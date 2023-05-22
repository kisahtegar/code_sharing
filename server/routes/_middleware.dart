import 'package:dart_frog/dart_frog.dart';
// import 'package:postgres/postgres.dart';
import 'package:stormberry/stormberry.dart';

// final connection = PostgreSQLConnection(
//   'localhost',
//   5432,
//   'postgres',
//   username: 'postgres',
//   password: 'changeme',
// );

// Handler middleware(Handler handler) {
//   return handler.use(provider<PostgreSQLConnection>((context) => connection));
// }

final db = Database(
  host: 'localhost',
  port: 5432,
  database: 'dbcodesharing',
  user: 'postgres',
  password: 'admin',
  useSSL: false,
  isUnixSocket: false,
);

Handler middleware(Handler handler) {
  return handler.use(provider<Database>((context) => db));
}
