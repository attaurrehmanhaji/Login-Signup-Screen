import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';
import 'package:login_signin_screens/src/features/notifications/notifications_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _darkMode = false;
  bool _biometricAuth = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildSectionHeader('Preferences'),
          _buildSwitchTile(
            'Push Notifications',
            'Receive alerts about orders and promos',
            _pushNotifications,
            (val) => setState(() => _pushNotifications = val),
            Icons.notifications_active,
          ),
          _buildSwitchTile(
            'Email Notifications',
            'Receive updates via email',
            _emailNotifications,
            (val) => setState(() => _emailNotifications = val),
            Icons.email,
          ),
          _buildSwitchTile(
            'Dark Mode',
            'Enable dark theme (Coming Soon)',
            _darkMode,
            (val) => setState(() => _darkMode = val),
            Icons.dark_mode,
          ),
          SizedBox(height: 25),

          _buildSectionHeader('Account & Security'),
          _buildSwitchTile(
            'Biometric Authentication',
            'Use FaceID or Fingerprint to login',
            _biometricAuth,
            (val) => setState(() => _biometricAuth = val),
            Icons.fingerprint,
          ),
          _buildNavigationTile(
            'Manage Notifications',
            'View past alerts',
            Icons.history,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsScreen()),
            ),
          ),
          _buildNavigationTile(
            'Change Password',
            'Update your account password',
            Icons.lock_reset,
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Password change flow mocked')),
              );
            },
          ),
          SizedBox(height: 25),

          _buildSectionHeader('About'),
          _buildNavigationTile(
            'Privacy Policy',
            'Read our privacy policy',
            Icons.privacy_tip,
            () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Privacy Policy mocked')));
            },
          ),
          _buildNavigationTile(
            'Terms of Service',
            'Read our terms of service',
            Icons.description,
            () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Terms mocked')));
            },
          ),
          _buildNavigationTile(
            'App Version',
            'v1.0.0',
            Icons.info_outline,
            () {},
            showArrow: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 5),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: AppColors.grayColor.withOpacity(0.6),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.orangeColor,
        secondary: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.lightOrangeColor.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.orangeColor, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.grayColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.grayColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool showArrow = true,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.lightOrangeColor.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.orangeColor, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.grayColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.grayColor.withOpacity(0.5),
          ),
        ),
        trailing: showArrow
            ? Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.grayColor.withOpacity(0.3),
              )
            : null,
      ),
    );
  }
}
