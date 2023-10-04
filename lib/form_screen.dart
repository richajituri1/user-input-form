import 'package:flutter/material.dart';
import 'data_display_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class InputFormScreen extends StatefulWidget {
  @override
  _InputFormScreenState createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
  List<String> genderOptions = ['Male', 'Female', 'Other'];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  String? _fullName;
  String? _email;
  String? _phoneNumber;
  String? _dateOfBirth;
  String? _gender;
  String? _address;
  File? _image;


  bool isValidDate(String date) {
    try {
      final components = date.split('-');
      if (components.length != 3) {
        return false;
      }
      final year = int.tryParse(components[0]);
      final month = int.tryParse(components[1]);
      final day = int.tryParse(components[2]);
      if (year == null || month == null || day == null) {
        return false;
      }
      final inputDate = DateTime(year, month, day);
      final currentDate = DateTime.now();
      return inputDate.isBefore(currentDate);
    } catch (e) {
      return false;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      _dateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Input'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _fullName = value;
                },
              ),
          
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value;
                },
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth (YYYY-MM-DD)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your date of birth';
                  } else if (!isValidDate(value)) {
                    return 'Please enter a valid date (YYYY-MM-DD)';
                  }
                  return null;
                },
                onSaved: (value) {
                  _dateOfBirth = value;
                },
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
              ),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Gender'),
                value: _gender,
                items: genderOptions.map((gender) {
                  return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                setState(() {
                _gender = value;
              });
            },
            validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your gender';
            }
            return null;
          },
          onSaved: (value) {
            _gender = value;
          },
        ),

        TextFormField(
          decoration: InputDecoration(labelText: 'Address'),
            validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your address';
            }
            return null;
          },
          onSaved: (value) {
            _address = value;
          },
        ),
        
        GestureDetector(
  onTap: () async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  },
  child: Column(
    children: <Widget>[
      _image == null
          ? Icon(Icons.add_a_photo)
          : Image.file(
              _image!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
      Text('Add Profile Picture'),
    ],
  ),
),


            SizedBox(height: 16.0),
              ElevatedButton(
                
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DataDisplayScreen(
                          fullName: _fullName!,
                          email: _email!,
                          phoneNumber: _phoneNumber!,
                          dateOfBirth: _dateOfBirth!,
                          gender: _gender!,
                          address: _address!,
                          profilePicture: _image, //Pass the selected image
                          
                        ),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.purpleAccent), // Set your desired background color
                ),
                child: Text('Submit'),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
