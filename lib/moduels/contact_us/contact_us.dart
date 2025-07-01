import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  // 🔗 لينك واتساب (عدّل الرقم حسب رقمك)
  final String whatsappUrl = 'https://wa.me/201030190456'; // رقمك بدون "+" وابدأ بـ 2 مصر

  void openWhatsApp(BuildContext context) async {
    final Uri uri = Uri.parse('https://wa.me/201030190456');

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح واتساب')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تواصل معنا'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📍 العنوان:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text('قرية الفرستق، مركز بسيون ، الغربية، مصر'),
            const SizedBox(height: 30),

            // زر واتساب
            Center(
              child: ElevatedButton.icon(
                onPressed: () => openWhatsApp(context),
                icon: const Icon(Icons.chat),
                label: const Text('تواصل عبر واتساب'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
