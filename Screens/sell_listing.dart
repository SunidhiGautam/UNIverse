import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample_app/Components/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  // Function to post a new listing
  void postListing(User currentUser) {
    final String name = nameController.text.trim();
    final String contact = contactController.text.trim();
    final String price = priceController.text.trim();
    final String description = descriptionController.text.trim();

    if (name.isNotEmpty && price.isNotEmpty && description.isNotEmpty) {
      FirebaseFirestore.instance.collection("Listing").add({
        'UserEmail': currentUser.email,
        'ProductName': name,
        'Price': price,
        'Contact': contact,
        'Description': description,
        'Timestamp': Timestamp.now(),
      });

      // Clear input fields after posting
      nameController.clear();
      contactController.clear();
      priceController.clear();
      descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == null) {
          return const Scaffold(
            body: Center(
              child: Text(
                "No user is logged in",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          );
        }

        final currentUser = snapshot.data!;
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 253, 237, 212),
          appBar: AppBar(
            title: Text(
              "Sell with Us",
              style: GoogleFonts.notoSerif(),
            ),
            backgroundColor: kPrimaryColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20), // Top spacing
                  // Heading Text
                  Text(
                    'What would you like to sell?',
                    style: GoogleFonts.openSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please add item details:',
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Product Name Field
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Price Field
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: contactController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Contact Details',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Description Field
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Logged in as
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Logged in as: ${currentUser.email}",
                      style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                  ),

                  // Post Listing Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () => postListing(currentUser),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFA743C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25),
                      ),
                      child: const Text(
                        'Post Listing',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
