import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyPostScreen extends StatelessWidget {
  const BuyPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Items for Sale"),
        backgroundColor: const Color(0xFFFA743C),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Listing")
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
            return const Center(child: Text("No items available for sale."));
          }

          final listings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: listings.length,
            itemBuilder: (context, index) {
              final listing = listings[index];
              final data = listing.data() as Map<String, dynamic>;

              return BuyList(
                productName: data['ProductName'] ?? 'No Product Name',
                price: data['Price']?.toString() ?? '0',
                description: data['Description'] ?? 'No Description',
                user: data['UserEmail'] ?? 'Unknown User',
              );
            },
          );
        },
      ),
    );
  }
}

class BuyList extends StatelessWidget {
  final String productName;
  final String price;
  final String description;
  final String user;

  const BuyList({
    super.key,
    required this.productName,
    required this.price,
    required this.description,
    required this.user,
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
              _buildText("Posted by: $user", 
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              _buildText(productName, 
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
              const SizedBox(height: 4),
              _buildText("Price: \$$price", 
                const TextStyle(fontSize: 14, color: Colors.green)),
              const SizedBox(height: 4),
              _buildText(description, 
                const TextStyle(fontSize: 14, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text, TextStyle style) {
    return Text(text, style: style);
  }
}
