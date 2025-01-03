import 'package:flutter/material.dart';
import '../modal/user_modal.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user.image),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "${user.firstName} ${user.lastName}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  "Username: ${user.username}",
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              _buildSection("Personal Details", [
                _buildDetail(Icons.email, "Email", user.email),
                _buildDetail(Icons.phone, "Phone", user.phone),
                _buildDetail(Icons.cake, "Date of Birth", user.birthDate),
                _buildDetail(Icons.person, "Gender", user.gender.name),
                _buildDetail(Icons.bloodtype, "Blood Group", user.bloodGroup),
                _buildDetail(Icons.height, "Height", "${user.height} cm"),
                _buildDetail(Icons.monitor_weight, "Weight", "${user.weight} kg"),
                _buildDetail(Icons.remove_red_eye, "Eye Color", user.eyeColor),
              ]),
              _buildSection("Address", [
                _buildDetail(
                  Icons.location_city,
                  "Address",
                  "${user.address.address}, ${user.address.city}, ${user.address.state}, ${user.address.postalCode}",
                ),
              ]),
              _buildSection("Company", [
                _buildDetail(Icons.work, "Company Name", user.company.name),
                _buildDetail(Icons.apartment, "Department", user.company.department),
              ]),
              _buildSection("Education", [
                _buildDetail(Icons.school, "University", user.university),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(IconData icon, String label, String value) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 8),
          ...details,
        ],
      ),
    );
  }
}
