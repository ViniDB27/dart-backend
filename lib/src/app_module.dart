import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import './features/user/user_resource.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        //Bind((i) => AppController()),
      ];

  @override
  List<ModularRoute> get routes => [
        Route.get('/', (Request request) => Response.ok('Success')),
        Route.resource(UserResource()),
      ];
}
