import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:shoppers/services/database.dart';
import 'package:shoppers/widget/support_widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController detailController = new TextEditingController();

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image!.path);
      setState(() {});
    }
  }

  uploadItem() async {
    print("uploading");
    if (selectedImage != null && nameController.text != "") {
      try {
        String addId = randomAlphaNumeric(10);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child("blogImage").child(addId);

        final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
        var downloadUrl = await (await task).ref.getDownloadURL();

        Map<String, dynamic> addProduct = {
          "Name": nameController.text,
          "Image": downloadUrl,
          "Price": priceController.text,
          "Detail": detailController.text,
        };

        await DatabaseMethods().addProduct(addProduct, value!).then((value) {
          selectedImage = null;
          nameController.text = "";
          priceController.text = "";
          detailController.text = "";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Product added successfully!',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Failed to add product!: $e',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Please select an image and enter a name!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }

  String? value;

  final List<String> categoryItem = [
    'Watch',
    'Laptops',
    'HeadPhones',
    'Tvs',
    'phones',
    'cables',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text(
          "Add Products",
          style: AppWidget.boldTextfieldStyle(),
        ),
      ),
      body: ListView(children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Upload Electronics Image",
                  style: AppWidget.semiboldTextfieldStyle(),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: getImage,
                  child: Column(
                    children: [
                      selectedImage == null
                          ? Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 100,
                                color: Colors.grey,
                              ),
                            )
                          : Container(
                              height: 150,
                              width: 200,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Electronic Name",
                style: AppWidget.semiboldTextfieldStyle(),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffececf8),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Samsung Galaxy A14 5G",
                    hintStyle: AppWidget.lightTextfieldStyle(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Electronic Price",
                style: AppWidget.semiboldTextfieldStyle(),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffececf8),
                ),
                child: TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Ksh. 20000",
                    hintStyle: AppWidget.lightTextfieldStyle(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Electronic Details",
                style: AppWidget.semiboldTextfieldStyle(),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffececf8),
                ),
                child: TextField(
                  maxLines: 6,
                  controller: detailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "ROM, 128GB, 4GB RAM ",
                    hintStyle: AppWidget.lightTextfieldStyle(),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Electronic Category",
                style: AppWidget.semiboldTextfieldStyle(),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    items: categoryItem
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: AppWidget.lightTextfieldStyle(),
                            ),
                          ),
                        )
                        .toList(),
                    dropdownColor: Colors.white,
                    value: value,
                    hint: Text(
                      "Select Category",
                      style: AppWidget.lightTextfieldStyle(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: uploadItem,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Add Electronic",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
