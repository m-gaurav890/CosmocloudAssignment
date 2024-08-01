import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appEmployeProvider.dart';
import 'appEmplyeModel.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _nameController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Add Employee',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.pink.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Employee Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: _nameController,
                  label: 'Name',
                  icon: Icons.person,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _addressLine1Controller,
                  label: 'Address Line 1',
                  icon: Icons.location_on,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _cityController,
                  label: 'City',
                  icon: Icons.location_city,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _countryController,
                  label: 'Country',
                  icon: Icons.flag,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _zipCodeController,
                  label: 'Zip Code',
                  icon: Icons.code,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final newEmployee = Employee(
                        id: '', // Assuming ID is auto-generated
                        name: _nameController.text,
                        addressLine1: _addressLine1Controller.text,
                        city: _cityController.text,
                        country: _countryController.text,
                        zipCode: _zipCodeController.text,
                        email: _emailController.text,
                      );

                      try {
                        await Provider.of<EmployeeProvider>(context, listen: false).addEmployee(newEmployee);
                        Navigator.of(context).pop(); // Return to the previous screen
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error adding employee: $e'),
                          ),
                        );
                      }
                    },
                    icon: Icon(Icons.add,color: Colors.white),
                    label: Text(
                      'Add Employee',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
