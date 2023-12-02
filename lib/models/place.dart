import 'package:uuid/uuid.dart';
const puid = Uuid();
class Place {

  Place({required this.title}):id=puid.v4();
  final String id;
  final String title;
}
