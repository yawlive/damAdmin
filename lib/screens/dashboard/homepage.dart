import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../sidebar/RegionManage.dart';
import '../../sidebar/RestoManage.dart';
import '../../sidebar/ReviewManage.dart';
import '../../sidebar/users.dart';
import '../login/loginScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  Map<String, dynamic> stats={
    'regions': '0',
    'rests': '0',
  };

  Future<void> getregions() async {
    var response = await http.get(Uri.parse(
        "http://192.168.56.1/damproject/stats1.php"));
    if (response.statusCode == 200) {
      setState(() {
        stats = jsonDecode(response.body);

      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Admin Panel',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(LineAwesomeIcons.bell),
              onPressed: () {

              },
            ),
            IconButton(
              icon: const Icon(LineAwesomeIcons.user_secret),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Loginscreen()),
                );
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black54),
              child: Stack(
                children: [

                  Center(
                    child: Text(
                      'Admin Menu',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 8,
                    right: -40,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/plats.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(LineAwesomeIcons.map),
              title: Text('Regions', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageRegionsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(LineAwesomeIcons.utensils),
              title: Text('Restaurants', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageRestaurantsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(LineAwesomeIcons.star),
              title: Text('Reviews', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageReviewsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(LineAwesomeIcons.user_friends),
              title: Text('Admins', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageUsersPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://pbs.twimg.com/media/FqGqu9naYAA6Knt?format=jpg&name=4096x4096'),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kang Minhee',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'kangMinhee@gmail.com',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Quick Access',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShortcutCard('Regions', LineAwesomeIcons.map, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ManageRegionsPage()),
                    );
                  }),
                  _buildShortcutCard('Restaurants', LineAwesomeIcons.utensils, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ManageRestaurantsPage()),
                    );
                  }),
                  _buildShortcutCard('Reviews', LineAwesomeIcons.star, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ManageReviewsPage()),
                    );
                  }),
                  _buildShortcutCard('Admins', LineAwesomeIcons.user_friends, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ManageUsersPage()),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMetricCard('Total Restaurants', stats['rests'].toString(), LineAwesomeIcons.utensils),
                    _buildMetricCard('Active Regions', stats['regions'], LineAwesomeIcons.map),
                    _buildMetricCard('Total Users', '320', LineAwesomeIcons.user_friends),
                    _buildMetricCard('Total Reviews', '500', LineAwesomeIcons.star),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Insights',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Chart Placeholder',
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Restaurants',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.lime.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(LineAwesomeIcons.utensils,
                                    color: Colors.lime),
                                title: Text('Restaurant ${index + 1}', style: GoogleFonts.poppins()),
                                subtitle: Text('Added on: 2024-12-30',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.grey)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Reviews',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(LineAwesomeIcons.star, color: Colors.amber),
                                title: Text('Review ${index + 1}', style: GoogleFonts.poppins()),
                                subtitle: Text('Date: 2024-12-30',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.grey)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30, color: Colors.lime.shade600),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildShortcutCard(String title, IconData icon, VoidCallback onTap) {
    return MouseRegion(
      onEnter: (_) => SystemMouseCursors.click,
      onExit: (_) => SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.lime.withOpacity(0.2),
              child: Icon(icon, size: 20, color: Colors.lime.shade600),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
