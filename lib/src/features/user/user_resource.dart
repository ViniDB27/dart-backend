import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../../generated/prisma_client.dart';

class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/user', _findAllUsers),
        Route.get('/user/:id', _findUserById),
        Route.post('/user', _createNewUser),
        Route.put('/user/:id', _updateUserById),
        Route.delete('/user/:id', _removeUserById),
      ];

  FutureOr<Response> _findAllUsers() async {
    final PrismaClient prisma = PrismaClient();

    try {
      final users = await prisma.user.findMany();
      return Response.ok(jsonEncode(users));
    } catch (e) {
      return Response.internalServerError(body: e.toString());
    } finally {
      await prisma.$disconnect();
    }
  }

  FutureOr<Response> _findUserById(ModularArguments arguments) async {
    final PrismaClient prisma = PrismaClient();

    try {
      final user = await prisma.user.findUnique(
        where: UserWhereUniqueInput(
          id: arguments.params['id'],
        ),
      );

      if (user == null) {
        return Response.notFound('User not found');
      }
      return Response.ok(user.toJson());
    } catch (e) {
      return Response.internalServerError(body: e.toString());
    } finally {
      await prisma.$disconnect();
    }
  }

  FutureOr<Response> _createNewUser(ModularArguments arguments) async {
    final body = arguments.data;

    final PrismaClient prisma = PrismaClient();

    try {
      final User user = await prisma.user.create(
        data: UserCreateInput(
          name: body['name'],
          email: body['email'],
          password: body['password'],
        ),
      );
      return Response.ok(jsonEncode(user));
    } catch (e) {
      return Response.badRequest(body: e.toString());
    } finally {
      await prisma.$disconnect();
    }
  }

  FutureOr<Response> _updateUserById(ModularArguments arguments) {
    return Response.ok("User: ${arguments.data}");
  }

  FutureOr<Response> _removeUserById(ModularArguments arguments) {
    return Response.ok("User: ${arguments.data}");
  }
}
