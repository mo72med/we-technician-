import 'package:flutter/foundation.dart';

import '../model/complaint.dart';
import '../services/api_service.dart';

class ComplaintManager extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Complaint> _allComplaints = [];
  List<Complaint> _employeeComplaints = [];
  List<Complaint> _areaComplaints = [];
  bool _isLoading = false;
  num _userId = 0;
  String _userName = "";

  List<Complaint> get allComplaints => _allComplaints;
  List<Complaint> get employeeComplaints => _employeeComplaints;
  List<Complaint> get areaComplaints => _areaComplaints;
  bool get isLoading => _isLoading;
  num get userId => _userId;
  String get userName => _userName;

  Future<void> fetchComplaints(num technicianId) async {
    _isLoading = true;
    _userId = technicianId;
    notifyListeners();
    try {
      _allComplaints = await _apiService.fetchComplaints();
      _userName = _allComplaints
          .firstWhere((complaint) => complaint.technicianId == technicianId)
          .technicianName;

      _employeeComplaints = _allComplaints
          .where((complaint) =>
              complaint.technicianId == technicianId &&
              complaint.testTime != 'finish')
          .toList();

      _areaComplaints = _allComplaints
          .where((complaint) =>
              complaint.technicianId == 0 && complaint.testTime != 'finish')
          .toList(); // يمكن تخصيص الفلترة إذا لزم الأمر
    } catch (e) {
      _employeeComplaints = [];
      _areaComplaints = _allComplaints
          .where((complaint) =>
              complaint.technicianId == 0 && complaint.testTime != 'finish')
          .toList();
      print("Error fetching complaints: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> transferComplain(num serviceNo, int index) async {
    try {
      await _apiService.transferComplain(serviceNo, _userId, _userName);
      _areaComplaints.removeWhere((complaint) => complaint.telNo == serviceNo);
      fetchComplaints(_userId);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error marking as finished: $e");
      }
    }
  }

  Future<void> markAsFinished(num serviceNo) async {
    try {
      await _apiService.markAsFinished(serviceNo);
      _employeeComplaints
          .removeWhere((complaint) => complaint.telNo == serviceNo);
      fetchComplaints(_userId);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error marking as finished: $e");
      }
    }
  }
}
