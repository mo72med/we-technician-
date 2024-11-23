class Complaint {
  final String createdBy;
  final int complainNo;
  final String statusCode;
  final String exchCode;
  final String complainTime;
  final String dispatchTime;
  final String repmanCode;
  final String lineTypeCode;
  final int dispFlag;
  final String cityCode;
  final num telNo;
  final String testTime;
  final String testUser;
  final String dispatchUser;
  final String cableNo;
  final String cabinetNo;
  final String commitmentTime;
  final String mdfCenter;
  final dynamic onu;
  final String currentlyAccessed;
  final String customerSegment;
  final int dispCount;
  final String closeDate;
  final String transferTime;
  final dynamic processType;
  final String gponNo;
  final String passive;
  final String complainTypeName;
  final String workOrderDate;
  final dynamic workOrderNo;
  final num technicianId;
  final String technicianName;

  Complaint({
    required this.createdBy,
    required this.complainNo,
    required this.statusCode,
    required this.exchCode,
    required this.complainTime,
    required this.dispatchTime,
    required this.repmanCode,
    required this.lineTypeCode,
    required this.dispFlag,
    required this.cityCode,
    required this.telNo,
    required this.testTime,
    required this.testUser,
    required this.dispatchUser,
    required this.cableNo,
    required this.cabinetNo,
    required this.commitmentTime,
    required this.mdfCenter,
    required this.onu,
    required this.currentlyAccessed,
    required this.customerSegment,
    required this.dispCount,
    required this.closeDate,
    required this.transferTime,
    required this.processType,
    required this.gponNo,
    required this.passive,
    required this.complainTypeName,
    required this.workOrderDate,
    required this.workOrderNo,
    required this.technicianId,
    required this.technicianName,
  });

  factory Complaint.fromJson(List<dynamic> json) {
    return Complaint(
      createdBy: json[0] ?? '',
      complainNo: json[1] ?? 0,
      statusCode: json[2] ?? '',
      exchCode: json[3] ?? '',
      complainTime: json[4] ?? '',
      dispatchTime: json[5] ?? '',
      repmanCode: json[6] ?? '',
      lineTypeCode: json[7] ?? '',
      dispFlag: json[8] ?? 0,
      cityCode: json[9] ?? '',
      telNo: json[10] ?? 0,
      testTime: json[11] ?? '',
      testUser: json[12] ?? '',
      dispatchUser: json[13] ?? '',
      cableNo: json[14] ?? '',
      cabinetNo: json[15] ?? '',
      commitmentTime: json[16] ?? '',
      mdfCenter: json[17] ?? '',
      onu: json[18],
      currentlyAccessed: json[19] ?? '',
      customerSegment: json[20] ?? '',
      dispCount: json[21] ?? 0,
      closeDate: json[22] ?? '',
      transferTime: json[23] ?? '',
      processType: json[24],
      gponNo: json[25] ?? '',
      passive: json[26] ?? '',
      complainTypeName: json[27] ?? '',
      workOrderDate: json[28] ?? '',
      workOrderNo: json[29],
      technicianName: json[30] ?? '',
      technicianId: json[31] ?? 0,
    );
  }
}
