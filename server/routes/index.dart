import 'dart:async';
import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:db/db.dart' as db;
// import 'package:postgres/postgres.dart';
import 'package:shared/shared.dart';
import 'package:stormberry/stormberry.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  // const user = User(id: 'asdf', email: 'some@user.com');
  // final connection = context.read<PostgreSQLConnection>();
  // await connection.open();

  // final result = await connection.query('SELECT NOW()');
  // print(result);

  final db = context.read<Database>();

  final user = await db.users.queryUser(2);

  if (user == null) {
    return Response(body: 'Not Found', statusCode: 404);
  }

  final sharedUser = User.fromDb(user);
  return Response.json(
    body: sharedUser.toJson(),
    headers: {'Content-Type': 'application/json'},
  );
}
