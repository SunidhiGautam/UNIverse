import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllListingsScreen extends StatelessWidget {
  const AllListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Listings"),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Listing") // Fetch data from the 'Listing' collection
            .orderBy('Timestamp', descending: true) // Order by most recent Timestamp
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No listings available"),
            );
          }

          final listings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: listings.length,
            itemBuilder: (context, index) {
              final data = listings[index].data() as Map<String, dynamic>;
              return ListingCard(data: data);
            },
          );
        },
      ),
    );
  }
}

class ListingCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const ListingCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
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
              data['ProductName'] ?? 'No Name',
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildText("Price: Rs. ${data['Price'] ?? 'N/A'}"),
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
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text, [TextStyle? style]) {
    return Text(
      text,
      style: style ?? const TextStyle(),
    );
  }
}
