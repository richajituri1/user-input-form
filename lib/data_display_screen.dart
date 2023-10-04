import 'dart:io';

import 'package:flutter/material.dart';

class DataDisplayScreen extends StatelessWidget {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String address;
  final File? profilePicture; 
  final String? username;
  final String? password;

  DataDisplayScreen({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    this.profilePicture,
    this.username,
    this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Display'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name: $fullName'),
            Text('Email: $email'),
            Text('Phone Number: $phoneNumber'),
            Text('Date of Birth: $dateOfBirth'),
            Text('Gender: $gender' ),
            Text('Address: $address'),
            if (profilePicture != null)
              Image.file(
                profilePicture!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            Text('Username: $fullName'),
          ],
        ),
      ),
    );
  }
}
