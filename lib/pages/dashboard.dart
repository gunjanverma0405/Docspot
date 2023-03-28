import 'package:flutter/material.dart';
import 'dart:math';

import '../utils/routes.dart';

class Doctor {
  final String hospitalName;
  final String name;
  final String availability;
  final String specialty;
  final double distance;
  final double longitude;
  final double latitude;

  Doctor(
      {required this.hospitalName,
      required this.name,
      required this.availability,
      required this.specialty,
      required this.distance,
      required this.longitude,
      required this.latitude});
}

class DoctorSearchPage extends StatefulWidget {
  @override
  _DoctorSearchPageState createState() => _DoctorSearchPageState();
}

class _DoctorSearchPageState extends State<DoctorSearchPage> {
  final List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_hospital),
      label: 'Ambulance Booking',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];
  int _currentIndex = 0;

  final List<Doctor> _doctors = [
    Doctor(
        hospitalName: 'Hospital A',
        name: 'Dr. John Doe',
        specialty: 'Cardiologist',
        availability: 'Yes',
        distance: 5.3,
        longitude: -73.9857,
        latitude: 40.7484),
    Doctor(
        hospitalName: 'Hospital A',
        name: 'Dr. John Doe',
        specialty: 'Cardiologist',
        availability: 'No',
        distance: 5.3,
        longitude: -73.9857,
        latitude: 40.7484),
    Doctor(
        hospitalName: 'Hospital A',
        name: 'Dr. Jane Smith',
        specialty: 'Pediatrician',
        availability: 'Yes',
        distance: 7.2,
        longitude: -73.9857,
        latitude: 40.7484),
    Doctor(
      hospitalName: 'Hospital B',
      name: 'Dr. Tom Johnson',
      specialty: 'Orthopedist',
      availability: 'Yes',
      distance: 3.8,
      longitude: -73.9857,
      latitude: 40.7484,
    ),
    Doctor(
      hospitalName: 'Hospital C',
      name: 'Dr. Sarah Lee',
      specialty: 'Dermatologist',
      availability: 'No',
      distance: 12.4,
      longitude: -73.9857,
      latitude: 40.7484,
    ),
    Doctor(
      hospitalName: 'Hospital A',
      name: 'Dr. Hannah Roger',
      specialty: 'Dermatologist',
      availability: 'Yes',
      distance: 11,
      longitude: -73.9857,
      latitude: 40.7484,
    ),
  ];
  List<Doctor> _searchResults = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    String searchText = _searchController.text.toLowerCase();
    List<Doctor> filteredDoctors = _doctors
        .where((doctor) => doctor.specialty.toLowerCase().contains(searchText))
        .toList();
    filteredDoctors.sort((a, b) => a.distance.compareTo(b.distance));
    setState(() {
      _searchResults = filteredDoctors;
    });
  }

  void _onTileClicked(Doctor doctor) async {
    await ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google map location will be shared")));
    Navigator.pushNamed(context, MyRoutes.notificationRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for a specialist...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (BuildContext context, int index) {
          Doctor doctor = _searchResults[index];
          return InkWell(
            onTap: () => _onTileClicked(doctor),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(
                    doctor.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        doctor.specialty,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16.0,
                              color: Colors.grey[600],
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              '${doctor.distance} miles away',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'At ${doctor.hospitalName}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Availability: ${doctor.availability}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: doctor.availability == 'Yes'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            Navigator.pushNamed(context, MyRoutes.dashboardRoute);
          } else if (index == 1) {
            Navigator.pushNamed(context, MyRoutes.dashboardRoute);
          } else if (index == 2) {
            Navigator.pushNamed(context, MyRoutes.dashboardRoute);
          }
        },
        items: bottomNavBarItems,
      ),
    );
  }
}
