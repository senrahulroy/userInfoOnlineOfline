// user_data.dart
import 'package:hive/hive.dart';

// part 'user_data.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  String firstName;

  @HiveField(1)
  String lastName;

  @HiveField(2)
  String email;

  @HiveField(3)
  String message;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.message,
  });
}
