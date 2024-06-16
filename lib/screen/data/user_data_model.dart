// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  final String firstName;
  final String lastName;
  final String email;
  final String message;
  final DateTime dateAndTime;

  UserDetails({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.message,
    required this.dateAndTime,
  });

  UserDetails copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? message,
    DateTime? dateAndTime,
  }) =>
      UserDetails(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        message: message ?? this.message,
        dateAndTime: dateAndTime ?? this.dateAndTime,
      );

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    message: json["message"],
    dateAndTime: DateTime.parse(json["dateAndTime"]),
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "message": message,
    "dateAndTime": dateAndTime.toIso8601String(),
  };
}
