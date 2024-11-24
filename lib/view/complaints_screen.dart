import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/compalin_manager.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final complaintManager = Provider.of<ComplaintManager>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    accountName: Text(
                      Provider.of<ComplaintManager>(context, listen: false)
                          .userName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    accountEmail: Text(
                      'ID: ${Provider.of<ComplaintManager>(context, listen: false).userId}',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  _buildDrawerItem(context,
                      icon: Icons.home, text: 'الرئيسية', onTap: () {}),
                  _buildDrawerItem(
                    context,
                    icon: Icons.logout,
                    text: 'تسجيل الخروج',
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('LoginPage');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('الرئيسية'),
          bottom: const TabBar(
            tabs: [
              Tab(
                  icon: Icon(Icons.calendar_month_outlined),
                  text: 'مهام العامل'),
              Tab(
                  icon: Icon(Icons.calendar_month_outlined),
                  text: 'مهام المنطقة'),
              Tab(icon: Icon(Icons.location_on), text: 'المهام على الخريطة'),
            ],
          ),
        ),
        body: complaintManager.isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildComplaintList(
                      complaintManager.employeeComplaints, context,
                      isFirstTab: true),
                  _buildComplaintList(complaintManager.areaComplaints, context,
                      isFirstTab: false),
                  const Center(child: Text('المهام على الخريطة')),
                ],
              ),
      ),
    );
  }

  Widget _buildComplaintList(List complaints, BuildContext context,
      {bool isFirstTab = false}) {
    return ListView.builder(
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        final complaint = complaints[index];

        if (isFirstTab) {
          // Apply custom logic for the first tab
          return WorkOrderCard(
            time: complaint.complainTime.toString(),
            cityCode: complaint.cityCode,
            placeCabinet: '${complaint.exchCode}/${complaint.cabinetNo}',
            requestType: complaint.complainTypeName,
            statusCode: complaint.statusCode,
            serviceNo: complaint.telNo,
            onPressed: () {
              Navigator.of(context).pushNamed(
                'ComplainDetailsScreen',
                arguments: index,
              );
            },
            iconData: Icons.menu,
            // Special behavior for the first tab
          );
        } else {
          // General logic for other tabs
          return WorkOrderCard(
            time: complaint.complainTime.toString(),
            cityCode: complaint.cityCode,
            placeCabinet: '${complaint.exchCode}/${complaint.cabinetNo}',
            requestType: complaint.complainTypeName,
            statusCode: complaint.statusCode,
            serviceNo: complaint.telNo,
            onPressed: () {
              Provider.of<ComplaintManager>(context, listen: false)
                  .transferComplain(complaint.telNo, index);
            },
            iconData: Icons.data_saver_on,
          );
        }
      },
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon,
      required String text,
      required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(text, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}

class WorkOrderCard extends StatelessWidget {
  final String time;
  final String cityCode;
  final String placeCabinet;
  final String requestType;
  final String statusCode;
  final num serviceNo;
  final VoidCallback onPressed;
  final IconData iconData;

  const WorkOrderCard({
    Key? key,
    required this.time,
    required this.cityCode,
    required this.placeCabinet,
    required this.requestType,
    required this.statusCode,
    required this.serviceNo,
    required this.onPressed,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(cityCode),
              ],
            ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Place/Cabinet: $placeCabinet'),
                    Row(
                      children: [
                        CircleButtonWidget(
                          icon: const Icon(Icons.location_on,
                              color: Colors.black),
                          onPressed: () {
                            // Action for location icon
                          },
                        ),
                        CircleButtonWidget(
                          icon: const Icon(Icons.map_outlined,
                              color: Colors.black),
                          onPressed: () {
                            // Action for map icon
                          },
                        ),
                        CircleButtonWidget(
                          icon: Icon(iconData, color: Colors.black),
                          onPressed: onPressed,
                        ),
                      ],
                    ),
                  ],
                ),
                Text('Complain Type: $requestType'),
                Text('Status Code: $statusCode'),
                Text('Service No: $serviceNo'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircleButtonWidget extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;

  const CircleButtonWidget({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.lightBlue, // Customize color as needed
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
          iconSize: 24.0,
          color: Colors.white, // Icon color
        ),
      ),
    );
  }
}
