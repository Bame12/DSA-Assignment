import 'package:flutter/material.dart';
import 'package:doctor_finder/models/doctor_model.dart';
import 'package:doctor_finder/screens/doctor_details_screen.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({Key? key}) : super(key: key);

  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  List<Doctor> _doctors = [];
  List<Doctor> _filteredDoctors = [];
  String _selectedSpecialty = 'All';
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  final List<String> _specialties = [
    'All',
    'General Practitioner',
    'Cardiologist',
    'Pediatrician',
    'Dentist',
    'Orthopedic',
    'Psychiatrist',
    'Neurologist',
  ];

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  void _loadDoctors() {
    // In a real app, this would be fetched from Firebase
    // For now, we'll use dummy data
    setState(() {
      _isLoading = true;
    });

    // Add a slight delay to simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      final List<Doctor> doctors = [
        Doctor(
          id: 'doctor1',
          name: 'Dr. Sarah Johnson',
          specialty: 'General Practitioner',
          about: 'General practitioner with 10 years of experience in family medicine. Specializes in preventive care and management of chronic conditions.',
          email: 'sarah.johnson@example.com',
          phone: '+267 1234 5678',
          address: '123 Main Street',
          city: 'Gaborone',
          latitude: -24.6282,
          longitude: 25.9231,
          photoUrl: '',
          isAvailable: true,
          acceptsInsurance: true,
          rating: 4.5,
          reviewCount: 24,
          experience: 10,
          education: 'MD, University of Botswana',
        ),
        Doctor(
          id: 'doctor2',
          name: 'Dr. Michael Smith',
          specialty: 'Cardiologist',
          about: 'Heart specialist with advanced training. Provides comprehensive cardiovascular care with expertise in heart disease prevention and treatment.',
          email: 'michael.smith@example.com',
          phone: '+267 2345 6789',
          address: '456 Hospital Road',
          city: 'Gaborone',
          latitude: -24.6500,
          longitude: 25.9000,
          photoUrl: '',
          isAvailable: true,
          acceptsInsurance: true,
          rating: 4.8,
          reviewCount: 36,
          experience: 15,
          education: 'MD, PhD, Harvard Medical School',
        ),
        Doctor(
          id: 'doctor3',
          name: 'Dr. Emily Wilson',
          specialty: 'Pediatrician',
          about: 'Child specialist focusing on newborn care, developmental milestones, and childhood illnesses. Passionate about preventive healthcare for children.',
          email: 'emily.wilson@example.com',
          phone: '+267 3456 7890',
          address: '789 Children Avenue',
          city: 'Gaborone',
          latitude: -24.6400,
          longitude: 25.9100,
          photoUrl: '',
          isAvailable: true,
          acceptsInsurance: true,
          rating: 4.9,
          reviewCount: 42,
          experience: 8,
          education: 'MD, University of Cape Town',
        ),
        Doctor(
          id: 'doctor4',
          name: 'Dr. David Chen',
          specialty: 'Dentist',
          about: 'Experienced dentist providing comprehensive dental care including preventive, restorative, and cosmetic services.',
          email: 'david.chen@example.com',
          phone: '+267 4567 8901',
          address: '101 Smile Street',
          city: 'Gaborone',
          latitude: -24.6350,
          longitude: 25.9150,
          photoUrl: '',
          isAvailable: true,
          acceptsInsurance: false,
          rating: 4.7,
          reviewCount: 31,
          experience: 12,
          education: 'DDS, University of Pretoria',
        ),
        Doctor(
          id: 'doctor5',
          name: 'Dr. James Thompson',
          specialty: 'Neurologist',
          about: 'Brain and nervous system specialist with expertise in treating headaches, seizures, and stroke recovery.',
          email: 'james.thompson@example.com',
          phone: '+267 7656 6637',
          address: '24 Brain Street',
          city: 'Gaborone',
          latitude: -24.6280,
          longitude: 25.9200,
          photoUrl: '',
          isAvailable: true,
          acceptsInsurance: true,
          rating: 4.6,
          reviewCount: 28,
          experience: 18,
          education: 'MD, Johns Hopkins University',
        ),
      ];

      setState(() {
        _doctors = doctors;
        _filteredDoctors = doctors;
        _isLoading = false;
      });
    });
  }

  void _filterDoctors() {
    setState(() {
      if (_selectedSpecialty == 'All') {
        _filteredDoctors = _doctors.where((doctor) {
          final name = doctor.name.toLowerCase();
          final city = doctor.city.toLowerCase();
          final query = _searchController.text.toLowerCase();
          return name.contains(query) || city.contains(query);
        }).toList();
      } else {
        _filteredDoctors = _doctors.where((doctor) {
          final match = doctor.specialty == _selectedSpecialty;
          if (_searchController.text.isEmpty) return match;
          
          final name = doctor.name.toLowerCase();
          final city = doctor.city.toLowerCase();
          final query = _searchController.text.toLowerCase();
          return match && (name.contains(query) || city.contains(query));
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Doctors'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or city',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => _filterDoctors(),
            ),
          ),
          
          // Info text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'Showing doctors within 200km',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedSpecialty = 'All';
                      _filterDoctors();
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Show All'),
                ),
              ],
            ),
          ),
          
          // Specialties filter
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _specialties.map((specialty) {
                bool isSelected = _selectedSpecialty == specialty;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FilterChip(
                    label: Text(specialty),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedSpecialty = specialty;
                        _filterDoctors();
                      });
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: Colors.blue.withOpacity(0.2),
                    checkmarkColor: Colors.blue,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Doctor list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredDoctors.isEmpty
                    ? const Center(child: Text('No doctors found'))
                    : ListView.builder(
                        itemCount: _filteredDoctors.length,
                        itemBuilder: (context, index) {
                          final doctor = _filteredDoctors[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                child: const Icon(Icons.person),
                              ),
                              title: Text(doctor.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(doctor.specialty),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                                      const SizedBox(width: 4),
                                      Text('${doctor.city}, ${doctor.address}'),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                                      const SizedBox(width: 4),
                                      Text(doctor.phone),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        doctor.rating.toString(),
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const Icon(Icons.star, color: Colors.amber, size: 16),
                                    ],
                                  ),
                                  Text(
                                    '${doctor.reviewCount} reviews',
                                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorDetailsScreen(doctor: doctor),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Find Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}
