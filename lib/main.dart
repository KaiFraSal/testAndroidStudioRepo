import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddressLogApp(),
    );
  }
}

class AddressLogApp extends StatefulWidget {
  @override
  _AddressLogAppState createState() => _AddressLogAppState();
}

class _AddressLogAppState extends State<AddressLogApp> {
  final List<String> _logs = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  void _addTask() {
    String name = _nameController.text.trim();
    String address = _addressController.text.trim();
    String contact = _contactController.text.trim();

    if (name.isNotEmpty && address.isNotEmpty && contact.isNotEmpty) {
      setState(() {
        _logs.add("Name: $name\nAddress: $address\nContact: $contact");
        _nameController.clear();
        _addressController.clear();
        _contactController.clear();
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _logs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Address Log App",
        ),
        backgroundColor: Color(0xffFFE800),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFF85B1A),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hoverColor: Colors.black,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter a name",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black, 
                                width: 3,
                              )
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter an address",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black, 
                                width: 3,
                              )
                            ),
                          ),
                        ),
                      ),
                      SizedBox  (
                        width: 300,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _contactController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter contact number",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black, 
                                width: 3,
                              )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 12),

                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      width: 3,
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    "Save",
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12.0),
              color: Color(0xff072083),
              child: _logs.isEmpty
              ? const Center(child: Text(
                style: TextStyle(
                  color: Colors.white,
                ),
                "No logs yet!",
                )
              )
              : ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_logs[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeTask(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}