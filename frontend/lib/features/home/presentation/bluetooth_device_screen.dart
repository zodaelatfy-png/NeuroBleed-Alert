import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../../../../core/theme/neuro_colors.dart';
import '../../../../core/theme/neuro_typography.dart';

class BluetoothDeviceScreen extends StatefulWidget {
  const BluetoothDeviceScreen({super.key});

  @override
  State<BluetoothDeviceScreen> createState() => _BluetoothDeviceScreenState();
}

class _BluetoothDeviceScreenState extends State<BluetoothDeviceScreen> {
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  void _initBluetooth() {
    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        _scanResults = results;
      });
    });

    FlutterBluePlus.isScanning.listen((state) {
      setState(() {
        _isScanning = state;
      });
    });
  }

  void _startScan() async {
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      debugPrint('Error starting scan: $e');
    }
  }

  void _stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect ESP32 Sensor', style: NeuroTypography.textTheme.headlineLarge),
        backgroundColor: NeuroColors.background,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Scanning for NeuroBleed ESP32 Vitals Sensors...',
              style: NeuroTypography.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          if (_isScanning) const LinearProgressIndicator(color: NeuroColors.primary),
          Expanded(
            child: ListView.builder(
              itemCount: _scanResults.length,
              itemBuilder: (context, index) {
                final r = _scanResults[index];
                final deviceName = r.device.platformName.isNotEmpty 
                    ? r.device.platformName 
                    : 'Unknown Device';

                // Filter logically to highlight ESP32
                final isEsp32 = deviceName.contains('ESP32') || deviceName.contains('Neuro');

                return ListTile(
                  leading: Icon(
                    Icons.bluetooth,
                    color: isEsp32 ? NeuroColors.primary : NeuroColors.textSecondary,
                  ),
                  title: Text(
                    deviceName,
                    style: TextStyle(
                      color: isEsp32 ? Colors.white : NeuroColors.textSecondary,
                      fontWeight: isEsp32 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: Text(r.device.remoteId.str),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEsp32 ? NeuroColors.secondary : NeuroColors.surface,
                    ),
                    onPressed: () {
                      r.device.connect();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Connecting to ${r.device.platformName}...')),
                      );
                    },
                    child: const Text('Connect'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _isScanning ? NeuroColors.emergency : NeuroColors.primary,
        onPressed: _isScanning ? _stopScan : _startScan,
        child: Icon(_isScanning ? Icons.stop : Icons.search, color: Colors.white),
      ),
    );
  }
}
