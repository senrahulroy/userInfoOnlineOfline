import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screen/data/user_data_model.dart';

class UserRepository {
   // UserRepository._();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUserDetails(UserDetails userDetails) async {
    try {
      await _db.collection('users').add(userDetails.toJson());
      debugPrint('User details added successfully!');
    } catch (e) {
      throw 'Something went wong. please try again';
      // Handle error
    }
  }


}
