import 'package:flutter/material.dart';
import '../../../../core/theme/neuro_colors.dart';
import 'user_main_dashboard.dart';
import 'bluetooth_device_screen.dart';
import '../../emergency/presentation/hospital_map_screen.dart';
import '../../admin/presentation/admin_dashboard.dart'; // Just as a placeholder for profile/history right now

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const UserMainDashboard(), // 0: الرئيسية
    const BluetoothDeviceScreen(), // 1: الأجهزة
    const HospitalMapScreen(), // 2: السجل (Placeholder map)
    const Center(child: Text('الملف الشخصي', style: TextStyle(color: Colors.white))), // 3: Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeuroColors.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: NeuroColors.border, width: 1)),
        ),
        child: BottomNavigationBar(
          backgroundColor: NeuroColors.surface,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: NeuroColors.primary,
          unselectedItemColor: NeuroColors.textSecondary,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.devices_other_outlined),
              activeIcon: Icon(Icons.devices_other),
              label: 'الأجهزة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              activeIcon: Icon(Icons.history),
              label: 'السجل',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'الملف الشخصي',
            ),
          ],
        ),
      ),
    );
  }
}
