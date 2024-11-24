import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/compalin_manager.dart';
import 'attached_widget.dart';
import 'material_widget.dart';

class ComplainDetailsScreen extends StatelessWidget {
  int index;

  ComplainDetailsScreen(
      {required this.index}); // Adding an index parameter to get the correct complaint

  @override
  Widget build(BuildContext context) {
    final complaintManager = Provider.of<ComplaintManager>(context);
    final complaint = complaintManager.employeeComplaints;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complain Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Allows for content overflow handling
        padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Information
            WorkOrderCard(
              time: complaint[index].complainTime.toString(),
              cityCode: complaint[index].cityCode,
              placeCabinet:
                  '${complaint[index].exchCode}/${complaint[index].cabinetNo}',
              requestType: complaint[index].complainTypeName,
              statusCode: complaint[index].statusCode,
              serviceNo: complaint[index].telNo,
              onPressed: () {},
            ),
            // Tab Bar and View
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: 'الاعمال'),
                      Tab(text: 'المهمات'),
                      Tab(text: 'مرفقات'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.5, // Adjust height
                    child: TabBarView(
                      children: [
                        const ActsWidget(),
                        const MaterialWidget(),
                        AttachedWidget(onPressed: () {
                          Provider.of<ComplaintManager>(context, listen: false)
                              .markAsFinished(complaint[index].telNo);
                          Navigator.pop(context);
                        }),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ActsWidget extends StatelessWidget {
  const ActsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: const [
              Icon(Icons.search, color: Colors.grey),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
              ),
              Icon(Icons.mic, color: Colors.grey),
            ],
          ),
        ),
        // Space 20px
        const SizedBox(height: 20),
        // List Items
        ConstrainedBox(
          // Constrain height to fit within screen
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: ListView.builder(
            shrinkWrap: false, // Prevents internal scrolling
            itemCount: 12,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Radio(
                      value: index,
                      groupValue: null,
                      onChanged: (value) {},
                    ),
                    title: const Text('John'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {},
                          color: Colors.blue,
                        ),
                        const Text(
                          '1',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {},
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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

  const WorkOrderCard({
    Key? key,
    required this.time,
    required this.cityCode,
    required this.placeCabinet,
    required this.requestType,
    required this.statusCode,
    required this.serviceNo,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(cityCode, style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Place/Cabinet: $placeCabinet',
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 5),
                Text('Complain Type: $requestType',
                    style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 5),
                Text('Status Code: $statusCode',
                    style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 5),
                Text('Service No: $serviceNo',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
