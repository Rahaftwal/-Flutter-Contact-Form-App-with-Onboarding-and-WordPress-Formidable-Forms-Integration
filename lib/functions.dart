import 'package:flutter/foundation.dart';
import 'package:http/http.dart'
    as http; // Import the HTTP package for making HTTP requests
import 'dart:convert'; // Import Dart's convert library for encoding/decoding JSON

class ApiFunctions {
  // Make API URL configurable
  final String apiUrl;
  // Make credentials configurable
  final String username;
  final String password;

  // Constructor with required configuration
  ApiFunctions({
    required this.apiUrl,
    required this.username,
    required this.password,
  });

  // Submit form data to the API
  Future<bool> contactmeform({
    required String firstName,
    required String lastName,
    required String gender,
    required String dateOfBirth,
    required String yourAge,
    required String email,
    required String bestTimeToContact,
    required String message,
  }) async {
    try {
      final credentials = '$username:$password';
      final encodedCredentials = base64Encode(utf8.encode(credentials));

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Basic $encodedCredentials',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'gender': gender,
          'dateOfBirth': dateOfBirth,
          'age': yourAge,
          'email': email,
          'contactTime': bestTimeToContact,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) print('Form submitted successfully');
        return true;
      } else {
        if (kDebugMode) {
          print('Failed to submit form: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) print('Error occurred: $e');
      return false;
    }
  }
}
