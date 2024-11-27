import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample_app/Screens/lost.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllLostAndFoundScreen extends StatelessWidget {
  const AllLostAndFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lost & Found Items", style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            color: Colors.white,
          ),),
        backgroundColor: Color(0xFFFA743C),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Items") // Fetch data from the 'foundItems' collection
            .orderBy('Timestamp', descending: true) // Order by most recent Timestamp
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No lost and found items available"),
            );
          }

          final items = snapshot.data!.docs;

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(), // Adds space between items
            itemBuilder: (context, index) {
              final data = items[index].data() as Map<String, dynamic>;
              return LostAndFoundCard(data: data);
            },
          );
        },
      ),

       floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LostScreen()),
          );
        },
        backgroundColor: Color(0xFFFA743C),
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
    ));
  }
}

class LostAndFoundCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const LostAndFoundCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch the LostOrFound status
    String lostOrFound = data['LostOrFound'] ?? 'Unknown';
    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

    // Set the color based on Lost or Found status
    Color statusColor = lostOrFound == 'Lost' ? Colors.red : Colors.green;

    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildText(
              data['ProductName'] ?? 'No Name', // Renamed to ItemName for lost/found items
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildText(
              data['Description'] ?? 'No Description',
              const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            _buildText(
              "Contact: ${data['Contact'] ?? 'Not Available'}",
              const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            _buildText(
              "Posted by: ${data['UserEmail'] ?? 'Unknown'}",
              const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
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
    );
  }

  Widget _buildText(String text, [TextStyle? style]) {
    return Text(
      text,
      style: style ?? const TextStyle(),
      maxLines: 2, // Limit the text to 2 lines to prevent overflow
      overflow: TextOverflow.ellipsis, // Add ellipsis for overflowed text
    );
  }
}


