import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        // Wrapping the body in SingleChildScrollView to prevent overflow
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture section
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                  'images/profile_image.png'), // Replace with actual image
            ),
            const SizedBox(height: 16),

            // User name
            const Text(
              'Vinura Chirath', // Replace with dynamic user name if needed
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            // Email
            const Text(
              'vinurachirath@gmail.com', // Replace with dynamic email
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // Profile options
            _buildProfileOption(
              icon: Icons.account_box,
              title: 'Personal Information',
              onTap: () {
                // Navigate to Personal Information Screen
              },
            ),
            _buildProfileOption(
              icon: Icons.history,
              title: 'Activity History',
              onTap: () {
                // Navigate to Activity History Screen
              },
            ),
            _buildProfileOption(
              icon: Icons.notifications,
              title: 'Notification Settings',
              onTap: () {
                // Navigate to Notification Settings Screen
              },
            ),
            const Divider(
              color: Colors.grey, // Divider between options
              thickness: 0.5,
            ),
            const SizedBox(height: 24),

            // Logout button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              onPressed: () {
                // Implement logout functionality
              },
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Profile option widget
  Widget _buildProfileOption(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.orange,
          size: 28,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }
}
