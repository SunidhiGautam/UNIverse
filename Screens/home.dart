import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample_app/Screens/buylistingpost.dart';
import 'package:firebase_sample_app/Screens/sell_listing.dart';
import 'package:firebase_sample_app/lAndfpost.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_sample_app/Screens/welcome_screen.dart';
import 'package:firebase_sample_app/Screens/about_us.dart';
import 'package:firebase_sample_app/Screens/found.dart';
import 'package:firebase_sample_app/Screens/contact_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userEmail;
  int _selectedIndex = 0; // Track the selected index for navigation

  @override
  void initState() {
    super.initState();
    userEmail = FirebaseAuth.instance.currentUser?.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFA743C),
        title: Text(
          'UNIverse',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFFef2e2),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFFFA743C),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'UNIverse',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hi, ${userEmail ?? "Guest"}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(Icons.home, 'Home', () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomePage()));
              }),
              _buildDrawerItem(Icons.list, 'My Listings', () {
                // Add your "My Listings" functionality here
              }),
              _buildDrawerItem(Icons.info, 'About Us', () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AboutUsScreen()));
              }),
              _buildDrawerItem(Icons.help, 'Help', () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ContactUsScreen()));
              }),
              _buildDrawerItem(Icons.logout, 'Log out', () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                );
              }),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 250,
              ),
              const SizedBox(height: 20),
              const Text(
                'Unlock Your UNIverse!\nConnect, Buy, Sell, and More',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 13,
                  childAspectRatio: 1, // Square cards
                ),
                children: [
                  _buildCardOption('Buy', Icons.shopping_cart_outlined, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AllListingsScreen()),
                    );
                  }),
                  _buildCardOption('Sell', Icons.attach_money_outlined, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ListingScreen()),
                    );
                  }),
                  _buildCardOption('Lost', Icons.search_outlined, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AllLostAndFoundScreen()),
                    );
                  }),
                  _buildCardOption('Found', Icons.check_circle_outline, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FoundScreen()),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFFA743C),
        selectedItemColor: const Color(0xFFFAB130),
        unselectedItemColor: const Color(0xFFFef2e2),
        currentIndex: _selectedIndex, // Track the selected index
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Navigate to respective screens based on the selected index
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            // Navigate to My Listings screen
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutUsScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactUsScreen()),
          );
        },
        backgroundColor: const Color(0xFFFAB130),
        child: const Icon(
          Icons.feedback,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFA8130)),
      title: Text(title, style: const TextStyle(color: Color(0xFFFA8130))),
      onTap: onTap,
    );
  }

  Widget _buildCardOption(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.orange),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}