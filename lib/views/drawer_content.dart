import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerContent extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onLogout;

  DrawerContent({required this.onClose, required this.onLogout});

  Widget _buildSection(String title, IconData icon, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.deepPurple),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        ...items.map((e) => ListTile(
          title: Text(e),
          contentPadding: EdgeInsets.only(left: 64),
          onTap: () => Get.snackbar("Clicked", e),
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(12),
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: onClose,
              ),
            ),
            _buildSection("Medical Records", Icons.medical_services, [
              "Health Records",
              "Appointment",
              "Medical Records",
              "Documents",
              "Family Members",
              "Demographics/Screening"
            ]),
            _buildSection("My Orders", Icons.shopping_bag, [
              "Profile",
              "Address",
              "Reset Password"
            ]),
            _buildSection("Financial", Icons.account_balance_wallet, [
              "Wallet",
              "Share MySmartCareDoc App",
              "Rate App"
            ]),
            _buildSection("Support", Icons.support_agent,
                ["Contact Us", "Send Feedback", "FAQs"]),
            _buildSection("Legal", Icons.policy,
                ["Terms and Conditions", "Privacy Policy"]),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: onLogout,
            ),
          ],
        ),
      ),
    );
  }
}
