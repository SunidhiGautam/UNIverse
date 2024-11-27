import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class LostScreen extends StatefulWidget {
  const LostScreen({super.key});

  @override
  State<LostScreen> createState() => _LostScreenState();
}

class _LostScreenState extends State<LostScreen> {
  final TextEditingController itemnameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController itemdescriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String itemCategory = 'Select option';
  String itemStatus = 'Lost'; // Default status
  final List<String> categories = ['Select option', 'Book', 'ID Card', 'Electronics', 'Other'];
  final List<String> statusOptions = ['Lost', 'Found'];

  final ImagePicker picker = ImagePicker();
  XFile? pickedFile;

  void postLostItem(User currentUser) {
    final String itemname = itemnameController.text.trim();
    final String contact = contactController.text.trim();
    final String location = locationController.text.trim();
    final String itemdescription = itemdescriptionController.text.trim();

    if (itemname.isNotEmpty && location.isNotEmpty && itemdescription.isNotEmpty) {
      FirebaseFirestore.instance.collection("Items").add({
        'UserEmail': currentUser.email,
        'ProductName': itemname,
        'Category': itemCategory,
        'Location': location,
        'Contact': contact,
        'Description': itemdescription,
        'LostOrFound': itemStatus, // Include Lost or Found status
        'Timestamp': Timestamp.now(),
        if (pickedFile != null) 'ImagePath': pickedFile!.path, // Include image if available
      });

      // Clear input fields after posting
      itemnameController.clear();
      contactController.clear();
      locationController.clear();
      itemdescriptionController.clear();
      setState(() {
        pickedFile = null;
        itemCategory = 'Select option';
        itemStatus = 'Lost'; // Reset to default
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item reported successfully!')),
      );
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedFile = image;
    });
  }

  void _removeImage() {
    setState(() {
      pickedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFA743C),
        title: Text(
          'Lost Something?',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'Help by reporting your lost or found item!',
                style: GoogleFonts.openSans(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: itemnameController,
                      decoration: InputDecoration(
                        labelText: 'Item Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFA743C)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter item name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: itemCategory,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFA743C)),
                        ),
                      ),
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          itemCategory = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value == 'Select option') {
                          return 'Please select item category';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: itemStatus,
                      decoration: InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFA743C)),
                        ),
                      ),
                      items: statusOptions.map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          itemStatus = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: 'Location (Lost)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFA743C)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the location where you lost the item';
                        }
                        return null;
                      },
                    ),
                     const SizedBox(height: 16),
                    TextFormField(
                      controller: itemdescriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFA743C)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter item description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: contactController,
                      decoration: InputDecoration(
                        labelText: 'Your Contact Information',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFA743C)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide your contact information';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: _pickImage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 20,
                              ),
                            ),
                            icon: const Icon(Icons.image, color: Colors.black),
                            label: Text(
                              'Add Image',
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (pickedFile != null) ...[
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: Image.file(
                                File(pickedFile!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: _removeImage,
                              child: const Text('Remove Image'),
                            ),
                          ]
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          postLostItem(FirebaseAuth.instance.currentUser!);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 40,
                        ), backgroundColor: const Color(0xFFFA743C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Post Item',
                        style: GoogleFonts.openSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
