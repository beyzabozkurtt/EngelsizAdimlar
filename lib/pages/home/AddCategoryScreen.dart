import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;

class AddCategoryCardScreen extends StatefulWidget {
  const AddCategoryCardScreen({Key? key}) : super(key: key);

  @override
  _AddCategoryCardScreenState createState() => _AddCategoryCardScreenState();
}

class _AddCategoryCardScreenState extends State<AddCategoryCardScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  Future<void> _uploadData() async {
    if (_imageFile == null) return;

    try {
      // Resmi Firebase Storage'a yükle
      String fileName = Path.basename(_imageFile!.path);
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask;

      // Resmin URL'sini al
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Firestore'a verileri kaydet
      await FirebaseFirestore.instance.collection('categories').add({
        'title': _titleController.text,
        'address': _addressController.text,
        'description': _descriptionController.text,
        'location': _locationController.text,
        'image': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Yer eklendi!')),
      );

      // Formu temizle
      _titleController.clear();
      _addressController.clear();
      _descriptionController.clear();
      _locationController.clear();
      setState(() {
        _imageFile = null;
      });
    } catch (e) {
      print('Resim yükleme veya veri kaydetme hatası: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Yer Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Başlık'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Adres'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Konum'),
            ),
            const SizedBox(height: 15),
            _imageFile != null
                ? Image.file(
              _imageFile!,
              height: 150,
            )
                : const Text('Resim seçilmedi'),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Resim Seç'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadData,
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
