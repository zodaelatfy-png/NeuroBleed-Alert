import 'package:flutter/material.dart';
import '../../../../core/theme/neuro_colors.dart';
import '../../../../core/theme/neuro_typography.dart';
import 'package:google_fonts/google_fonts.dart';

class UserMainDashboard extends StatelessWidget {
  const UserMainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeuroColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for logo
            const Icon(Icons.psychology, color: NeuroColors.emergency, size: 28),
            const SizedBox(width: 8),
            Text(
              'NeuroBleed Alert',
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, // Arabic RTL alignment
          children: [
            const SizedBox(height: 8),
            Center(
              child: Text(
                'ذكاء اصطناعي لحماية دماغك',
                style: NeuroTypography.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 24),

            // Bluetooth Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: NeuroColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: NeuroColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Headband placeholder
                  Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(child: Icon(Icons.sensors, color: NeuroColors.primary)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('متصل بالجهاز', style: NeuroTypography.textTheme.titleLarge),
                      Text('NBA-HEADBAND-01', style: NeuroTypography.textTheme.bodyMedium?.copyWith(color: NeuroColors.primary)),
                    ],
                  ),
                  const Icon(Icons.bluetooth, color: NeuroColors.primary, size: 32),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Brain Status Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: NeuroColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: NeuroColors.border),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('حالة الدماغ الآن', style: NeuroTypography.textTheme.titleLarge),
                      const SizedBox(width: 8),
                      const Icon(Icons.show_chart, color: Colors.white54),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Probability Gauge
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  value: 0.18,
                                  strokeWidth: 8,
                                  backgroundColor: NeuroColors.surfaceHighlight,
                                  valueColor: const AlwaysStoppedAnimation<Color>(NeuroColors.emergency),
                                ),
                              ),
                              Text('18%', style: NeuroTypography.textTheme.displaySmall),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('احتمالية النزيف', style: NeuroTypography.textTheme.bodyMedium),
                        ],
                      ),
                      // Brain Image Placeholder
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: NeuroColors.surfaceHighlight,
                          boxShadow: [
                            BoxShadow(color: NeuroColors.primary.withOpacity(0.2), blurRadius: 20, spreadRadius: 5),
                          ],
                        ),
                        child: const Icon(Icons.psychology, size: 80, color: NeuroColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('آخر تحديث: منذ 30 ثانية 🕒', style: NeuroTypography.textTheme.bodyMedium),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: NeuroColors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: NeuroColors.secondary),
                        ),
                        child: Row(
                          children: [
                            Text('الحالة مستقرة', style: TextStyle(color: NeuroColors.secondary, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            const Icon(Icons.check_circle, color: NeuroColors.secondary, size: 16),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Vitals Grid
            Text('المؤشرات الحيوية', style: NeuroTypography.textTheme.titleLarge),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildVitalCard('درجة الحرارة', '36.6°C', Icons.thermostat, Colors.redAccent),
                _buildVitalCard('معدل النبض', '78 BPM', Icons.favorite, NeuroColors.emergency),
                _buildVitalCard('تدفق الدم للدماغ', '75%', Icons.psychology_alt, NeuroColors.primary),
                _buildVitalCard('تشبع الأكسجين', '96%', Icons.water_drop, Colors.cyan),
              ],
            ),
            const SizedBox(height: 24),

            // Emergency Alert Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF3B0D11), // Dark red background
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: NeuroColors.emergency.withOpacity(0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: NeuroColors.emergency, shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16), // RTL Arrow
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('حالة طارئة', style: NeuroTypography.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text('اضغط إذا شعرت بأي أعراض خطيرة', style: NeuroTypography.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                    ],
                  ),
                  const Icon(Icons.crisis_alert, color: NeuroColors.emergency, size: 40),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            Text('إجراءات سريعة', style: NeuroTypography.textTheme.titleLarge),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionIcon('سجل التقارير', Icons.assignment),
                _buildActionIcon('مشاركة موقعي', Icons.location_on),
                _buildActionIcon('أقرب مستشفى', Icons.local_hospital),
                _buildActionIcon('اتصال طوارئ', Icons.phone, isEmergency: true),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalCard(String title, String value, IconData icon, Color iconColor) {
    return Container(
      width: 75,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: NeuroColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeuroColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 10, color: NeuroColors.textSecondary), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildActionIcon(String title, IconData icon, {bool isEmergency = false}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: NeuroColors.surfaceHighlight,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: isEmergency ? NeuroColors.emergency : NeuroColors.primary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 12, color: NeuroColors.textSecondary)),
      ],
    );
  }
}
