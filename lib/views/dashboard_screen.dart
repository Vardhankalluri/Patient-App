import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login_screen.dart'; // Ensure this path is correct

// Define custom colors for consistency, matching the dark theme of Glow UI
const Color kDrawerBgColor = Color(0xFF1E1E1E); // Dark background
const Color kActiveItemColor = Color(0xFF673AB7); // Deep Purple for active item
const Color kInactiveItemColor = Color(0xFFEEEEEE); // Light grey for inactive text/icons
const Color kSubItemColor = Color(0xFFBBBBBB); // Slightly darker grey for sub-items
const Color kDividerColor = Color(0xFF333333); // Darker divider for dark theme

// Colors for the BottomNavigationBar (updated for new design)
const Color kBottomNavBgColor = Colors.deepPurple; // Deep purple background for the new nav bar
const Color kBottomNavInactiveColor = Colors.white70; // Slightly translucent white for inactive
const Color kBottomNavActiveColor = Colors.white; // Pure white for active item

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0; // Tracks the currently selected tab: 0=Home, 1=Notifications, 2=Logout

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation based on index
    if (index == 0) {
      Get.snackbar("Navigation", "Home Tapped!");
      // You can add navigation logic here, e.g., Get.to(() => HomeScreen());
    } else if (index == 1) {
      Get.snackbar("Navigation", "Notifications Tapped!");
      // Get.to(() => NotificationsScreen());
    } else if (index == 2) {
      Get.back(); // Close any open dialogs/drawers
      Get.offAll(() => LoginScreen()); // Navigate to login and clear stack
    }
  }

  // Reusable widget for a single drawer item (main or sub-item)
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    bool isActive = false,
    double indentLevel = 0.0, // Control indentation using a double
    VoidCallback? onTap,
    Color? textColor, // New: Optional custom text color
    Color? iconColor, // New: Optional custom icon color
  }) {
    return Container(
      color: isActive ? kActiveItemColor : Colors.transparent,
      margin: EdgeInsets.only(left: indentLevel), // Apply indentation
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor ?? (isActive ? Colors.white : kInactiveItemColor), // Use custom color or default
          size: 22,
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: textColor ?? (isActive ? Colors.white : kInactiveItemColor), // Use custom color or default
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: onTap ?? () => Get.snackbar("Tapped", title), // Default action
        hoverColor: isActive ? kActiveItemColor : Colors.grey.withOpacity(0.1),
      ),
    );
  }

  // Modified _buildSection to use the new styling
  Widget _buildSection({
    required IconData icon,
    required String title,
    required List<Map<String, dynamic>> items,
    bool isActiveSection = false, // To highlight the whole section if needed (like "Settings")
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header (similar to Glow UI's main items)
        _buildDrawerItem(
          icon: icon,
          title: title,
          isActive: isActiveSection, // Apply active styling if this section is the "active" one
          onTap: () => Get.snackbar("Section Tapped", title), // Example action
        ),
        // Sub-items for the section, using a fixed indent for consistency
        ...items.map((item) => _buildDrawerItem(
          icon: item['icon'],
          title: item['title'],
          indentLevel: 56.0, // Consistent indent as per your original code
          onTap: () => Get.snackbar("Clicked", item['title']),
        )),
      ],
    );
  }

  void showCustomDrawer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // This ensures tapping outside closes the drawer
      barrierLabel: "Drawer",
      transitionDuration: Duration(milliseconds: 300), // Slightly faster transition
      pageBuilder: (_, __, ___) => SizedBox.shrink(),
      transitionBuilder: (_, animation, __, ___) {
        return Container(
          // No BackdropFilter for blur, just a semi-transparent overlay
          color: Colors.black.withOpacity(0.5 * (1 - animation.value)), // Fades out overlay
          child: Align(
            alignment: Alignment.centerLeft,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(-1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
              child: Material(
                color: kDrawerBgColor, // Dark background for the drawer itself
                borderRadius: BorderRadius.horizontal(right: Radius.circular(0)), // No rounded corners
                clipBehavior: Clip.antiAlias, // Ensures content respects the sharp corners
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75, // Adjust width as per screenshot estimate
                  height: double.infinity, // Occupy full height
                  child: Column(
                    children: [
                      // Drawer Header with Back Arrow
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 40, 20, 20), // Adjusted padding
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white, size: 28), // Back Arrow
                              onPressed: () {
                                Get.back(); // Close the drawer
                              },
                            ),
                            SizedBox(width: 10), // Space between arrow and content
                            Expanded( // Use Expanded to allow text to take available space
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: kActiveItemColor, // Use active color for avatar
                                    child: Icon(Icons.person, size: 30, color: Colors.white),
                                  ),
                                  SizedBox(height: 10),
                                  Text("Welcome Back!",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)), // White text for dark theme
                                  Text("User Name",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: kSubItemColor)), // Lighter grey for sub-text
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero, // Remove default ListView padding
                          children: [
                            // Your original sections, styled with the new _buildSection and _buildDrawerItem
                            _buildSection(
                              icon: Icons.medical_services_outlined,
                              title: "Medical Records",
                              items: [
                                {"title": "Health Records", "icon": Icons.health_and_safety_outlined},
                                {"title": "Appointment", "icon": Icons.calendar_today_outlined},
                                {"title": "Medical Records", "icon": Icons.folder_copy_outlined},
                                {"title": "Documents", "icon": Icons.description_outlined},
                                {"title": "Family Members", "icon": Icons.group_add},
                                {"title": "Demographics/Screening", "icon": Icons.account_box_outlined},
                              ],
                            ),
                            Divider(thickness: 1, color: kDividerColor),
                            _buildSection(
                              icon: Icons.shopping_bag_outlined,
                              title: "My Orders",
                              items: [
                                {"title": "Profile", "icon": Icons.person},
                                {"title": "Address", "icon": Icons.location_on_outlined},
                                {"title": "Reset Password", "icon": Icons.lock_reset},
                              ],
                            ),
                            Divider(thickness: 1, color: kDividerColor),
                            _buildSection(
                              icon: Icons.account_balance_wallet_outlined,
                              title: "Financial",
                              items: [
                                {"title": "Wallet", "icon": Icons.account_balance_wallet},
                                {"title": "Share App", "icon": Icons.share},
                                {"title": "Rate App", "icon": Icons.star_rate_outlined},
                              ],
                            ),
                            Divider(thickness: 1, color: kDividerColor),
                            _buildSection(
                              icon: Icons.support_agent,
                              title: "Support",
                              items: [
                                {"title": "Contact Us", "icon": Icons.support},
                                {"title": "Send Feedback",
                                  "icon": Icons.feedback_outlined},
                                {"title": "FAQs", "icon": Icons.help_center_outlined},
                              ],
                            ),
                            Divider(thickness: 1, color: kDividerColor),
                            _buildSection(
                              icon: Icons.verified_user_outlined,
                              title: "Legal",
                              items: [
                                {"title": "Terms and Conditions", "icon": Icons.assignment_late_outlined},
                                {"title": "Privacy Policy", "icon": Icons.privacy_tip_outlined},
                              ],
                            ),
                            Divider(thickness: 1, color: kDividerColor),
                            // Logout button with red text and icon
                            _buildDrawerItem(
                              icon: Icons.logout,
                              title: "Logout",
                              textColor: Colors.red, // Custom text color
                              iconColor: Colors.red, // Custom icon color
                              onTap: () {
                                Get.back(); // Closes the drawer
                                Get.offAll(() => LoginScreen()); // Navigates to LoginScreen and removes all previous routes
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20), // Bottom padding
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // --- Dashboard Screen Widgets ---

  Widget buildGridTile({
    required IconData icon,
    required String title,
    required Color bgColor,
  }) {
    return InkWell(
      onTap: () => Get.snackbar("Tapped", title),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dotted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBlogCard({required String title}) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.health_and_safety, size: 36, color: Colors.deepPurple),
          SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, color: Colors.deepPurple.shade900),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // The BottomNavigationBar typically occupies kBottomNavigationBarHeight
    // plus the bottom SafeArea padding.
    // By having the body wrapped in SafeArea, the scrollable content will naturally
    // avoid overlapping the bottom navigation bar and system insets.
    final double bottomNavBarHeightWithSafeArea = kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.only(top: 30, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => showCustomDrawer(context),
              ),
              Text(
                "Dashboard",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 48),
            ],
          ),
        ),
      ),
      body: SafeArea( // Crucial for handling device specific insets (notches, home indicators)
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0), // Top and horizontal padding
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [ // Start of the SliverChildListDelegate children
                    TextField(
                      style: GoogleFonts.poppins(color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: "Search by Doctor Code/Name, Hospital Code...",
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                        prefixIcon: Icon(Icons.search_rounded, color: Colors.black54),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        buildGridTile(
                          icon: Icons.call_outlined,
                          title: "Call Us",
                          bgColor: Colors.teal,
                        ),
                        buildGridTile(
                          icon: FontAwesomeIcons.whatsapp,
                          title: "WhatsApp",
                          bgColor: Colors.green,
                        ),
                        buildGridTile(
                          icon: Icons.self_improvement,
                          title: "Yoga",
                          bgColor: Colors.orange,
                        ),
                        buildGridTile(
                          icon: Icons.health_and_safety_outlined,
                          title: "Wellness",
                          bgColor: Colors.red,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Instant Rewards",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Refer & Earn",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, color: Colors.black)),
                          SizedBox(height: 8),
                          Text("Invite a friend to increase your wallet balance.",
                              style: GoogleFonts.poppins(color: Colors.black87)),
                          SizedBox(height: 4),
                          Text("Know More →",
                              style: GoogleFonts.poppins(color: Colors.deepPurple)),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Health Blog",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 160,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          buildBlogCard(title: "Tips for Healthy Living"),
                          buildBlogCard(title: "Managing Stress Naturally"),
                          buildBlogCard(title: "Benefits of Daily Yoga"),
                        ],
                      ),
                    ),
                    // ********** BOTTOM PADDING FOR SCROLLABLE CONTENT **********
                    // Now using the calculated height that the new BottomNavigationBar
                    // and system safe area will occupy.
                    SizedBox(height: bottomNavBarHeightWithSafeArea),
                    // ************************************************************
                  ], // End of the SliverChildListDelegate children list
                ), // End of SliverChildListDelegate
              ), // End of SliverList
            ), // End of SliverPadding
          ], // End of slivers list
        ), // End of CustomScrollView
      ), // End of SafeArea
      // --- NEW BottomNavigationBar Implementation ---
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kBottomNavBgColor, // Set the background color
        selectedItemColor: kBottomNavActiveColor, // Color for the selected item
        unselectedItemColor: kBottomNavInactiveColor, // Color for unselected items
        currentIndex: _selectedIndex, // Connect to the state variable
        onTap: _onItemTapped, // Handle taps
        type: BottomNavigationBarType.fixed, // Ensures all items are visible and don't shift
        selectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_on_outlined),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login_outlined),
            label: "Logout",
          ),
        ],
      ),
    );
  }
}