import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lavajava/Models/Products.dart';
import 'package:lavajava/Widgets/CustomText.dart';

class imageUpload extends StatefulWidget {
  const imageUpload({Key key}) : super(key: key);

  @override
  _imageUploadState createState() => _imageUploadState();
}

File _image;
//final ImagePicker = ImagePicker();

class _imageUploadState extends State<imageUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Column(
                children: [
                  const Text("Upload Image"),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.orange[200])),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: _image == null
                                    ? const Center(
                                        child: Text("No image selected"))
                                    : Image.file(_image))
                          ],
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Select Image")),
                  ElevatedButton(onPressed: () {}, child: Text("Upload Image"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
