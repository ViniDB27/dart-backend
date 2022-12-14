import 'package:shelf/shelf_io.dart' as io;
import 'package:backend/backend.dart';

void main(List<String> arguments) async {
  final handler = await startShelfModular();
  final server = await io.serve(handler, '0.0.0.0', 4466);

  print("Server listening on http://${server.address.address}:${server.port}");
}
