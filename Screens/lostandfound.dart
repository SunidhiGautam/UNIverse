import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class LostAndFoundScreen extends StatelessWidget {
  const LostAndFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lost & Found Items", style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            color: Colors.white,
          ),),),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Items")
            .orderBy("Timestamp", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("An error occurred: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No lost and found items available."));
          }

          final items = snapshot.data!.docs;

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(), // Adds a separator between cards
            itemBuilder: (context, index) {
              final item = items[index];
              final data = item.data() as Map<String, dynamic>;

              // Fetch LostOrFound status and apply color
              String lostOrFound = data['LostOrFound'] ?? 'Unknown';
              Color statusColor = lostOrFound == 'Lost' ? Colors.red : Colors.green;

              return LostAndFoundList(
                productName: data['ProductName'] ?? 'No Item Name',
                location: data['Location'] ?? 'Unknown Location',
                description: data['Description'] ?? 'No Description',
                user: data['UserEmail'] ?? 'Unknown User',
                lostOrFound: lostOrFound,
                statusColor: statusColor,
              );
            },
          );
        },
      ),
    );
  }
}

class LostAndFoundList extends StatelessWidget {
  final String productName;
  final String location;
  final String description;
  final String user;
  final String lostOrFound;
  final Color statusColor;

  const LostAndFoundList({
    super.key,
    required this.productName,
    required this.location,
    required this.description,
    required this.user,
    required this.lostOrFound,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText("Posted by: $user", const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              _buildText(productName, const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
              const SizedBox(height: 4),
              _buildText("Location: $location", const TextStyle(fontSize: 14, color: Colors.blue)),
              const SizedBox(height: 4),
              _buildText(description, const TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 8),
              // Display the Lost or Found status
              Text(
                lostOrFound,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Optimized text builder with optional styles for customization
  Widget _buildText(String text, TextStyle style) {
    return Text(
      text,
      style: style,
      maxLines: 2, // Ensures that long texts don't overflow
      overflow: TextOverflow.ellipsis, // Adds ellipsis for text overflow
    );
  }
}
