import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universeproject/Screens/contact_page.dart';
 // Make sure you have a sell.dart file

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedOption = 'Buy'; // Default selected option
  bool isSellSelected = false; // To track if Sell is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFA743C), // Orange-Red
        title: Text(
          'UNIverse',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            color: Colors.white, // White for better contrast
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
          color: const Color(0xFFFef2e2), // Soft Beige for drawer background
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFFFA743C), // Orange-Red
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
                    const Text(
                      'Hi, Code Crush!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(Icons.person, 'My Profile', () {}),
              _buildDrawerItem(Icons.list, 'My Listings', () {}),
              _buildDrawerItem(Icons.logout, 'Log out', () {
                Navigator.pushReplacementNamed(context, '/login');
              }),
              _buildDrawerItem(Icons.help, 'Help', () {
                Navigator.push(context, MaterialPageRoute(builder: (context){return ContactUsScreen();}));
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
              // If Sell is selected, show the transition
              if (isSellSelected) ...[
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: 100,
                  child: const Text(
                    "Got something to sell?...We've got you!",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Please provide the following information:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                SellForm(),
              ],
              // Main content with icons if Sell is not selected
              if (!isSellSelected) ...[
                Image.asset(
                  'assets/images/app_icon.png',
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'What are you looking for today?',
                  style: TextStyle(
                    fontSize: 22, // Larger text for the section header
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                // Horizontal Icon Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildIconOption('Buy', Icons.shopping_cart_outlined),
                    _buildIconOption('Sell', Icons.attach_money_outlined),
                    _buildIconOption('Lost', Icons.search_outlined),
                    _buildIconOption('Found', Icons.check_circle_outline),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFFA743C), // Orange-Red for the navbar
        selectedItemColor: const Color(0xFFFAB130), // Golden Yellow for active items
        unselectedItemColor: const Color(0xFFFef2e2), // Beige for inactive items
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(), // Ensures the FAB is perfectly round
        onPressed: () {
          // Action when the FAB is pressed
          Navigator.push(context, MaterialPageRoute(builder: (context){return ContactUsScreen();}));
        },
        backgroundColor: const Color(0xFFFAB130), // Golden Yellow for FAB
        child: const Icon(
          Icons.feedback,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildIconOption(String label, IconData icon) {
    final isSelected = label == selectedOption;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = label;
          // If Sell is selected, trigger transition
          if (label == 'Sell') {
            isSellSelected = true;
          } else {
            isSellSelected = false;
          }
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: isSelected ? const Color(0xFFFA743C) : Colors.grey[300],
            child: Icon(
              icon,
              size: 30,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? const Color(0xFFFA743C) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFA8130)), // Bright Orange for icons
      title: Text(title, style: const TextStyle(color: Color(0xFFFA8130))),
      onTap: onTap,
    );
  }
}

// SellForm widget to be added below the header text
class SellForm extends StatelessWidget {
  const SellForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          DropdownButtonFormField<String>(
            items: const [
              DropdownMenuItem(value: 'Books', child: Text('Books')),
              DropdownMenuItem(value: 'Notes', child: Text('Notes')),
              DropdownMenuItem(value: 'Drafter', child: Text('Drafter')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: (value) {},
            decoration: InputDecoration(labelText: 'Category'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
          GestureDetector(
            onTap: () {
              // Implement image picker functionality
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.grey[200],
              child: const Text('Tap to add product image'),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement form submission
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}