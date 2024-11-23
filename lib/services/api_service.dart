import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/complaint.dart';

class ApiService {
  final String apiUrl =
      'https://script.google.com/macros/s/AKfycbzXgggnq9APBNGO4Yp6RbYLp4asZP5TTVmJ3jHyGmQBmyjXHiN2oii6cDxFPBI9n-Expw/exec';

  // Fetch complaints from Google Sheets
  Future<List<Complaint>> fetchComplaints() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<dynamic> complaintsList = data.sublist(1); // Skip header row

      List<Complaint> complaints =
          complaintsList.map((item) => Complaint.fromJson(item)).toList();

      return complaints;
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  // Mark a complaint as finished in Google Sheets
  Future<void> markAsFinished(num serviceNo) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'serviceNo': serviceNo, 'testTime': 'finish'}),
      );

      if (response.statusCode == 200) {
        print('Marked as finished');
      } else if (response.statusCode == 302) {
        // Handle redirection by checking the 'Location' header
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          print('Redirected to: $redirectUrl');
          // Optionally, you can send a request to the redirect URL here
        } else {
          throw Exception('Redirection occurred, but no location provided');
        }
      } else {
        throw Exception('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> transferComplain(
      num serviceNo, num technicianId, String technicianName) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'serviceNo': serviceNo,
          'technicianId': technicianId,
          'technicianName': technicianName
        }),
      );
      if (response.statusCode == 200) {
        print('Marked as finished');
      } else if (response.statusCode == 302) {
        // Handle redirection by checking the 'Location' header
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          print('Redirected to: $redirectUrl');
          // Optionally, you can send a request to the redirect URL here
        } else {
          throw Exception('Redirection occurred, but no location provided');
        }
      } else {
        throw Exception('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to connect to the server');
    }
  }
}
