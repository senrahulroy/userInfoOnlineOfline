import 'package:flutter/material.dart';

import '../../utils/core.dart';

class MessageCard extends StatelessWidget {
  final String? message;
  final String? name;
  final String? email;
  final String? dateAndTime;

  const MessageCard(
      {super.key, this.message, this.name, this.email, this.dateAndTime});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, right: 16, left: 16, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('"$message"', style: AppTextStyle.messageStyle),
              const SizedBox(height: 10),
              Text(name!, style: AppTextStyle.nameStyle),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(email!, style: AppTextStyle.emailStyle),
                  Text(dateAndTime!, style: AppTextStyle.emailStyle),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// List Tile With Cord
class MyUserDataList extends StatelessWidget {
  const MyUserDataList(
      {super.key,
      required this.message,
      required this.name,
      required this.email, required this.dateAndTime});

  final String message;
  final String name;
  final String email;
  final String  dateAndTime;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: MessageCard(message: message, name: name, email: email,dateAndTime: dateAndTime,),
        ),
      ],
    );
  }
}
