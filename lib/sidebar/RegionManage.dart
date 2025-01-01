import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ManageRegionsPage extends StatefulWidget {
  const ManageRegionsPage({Key? key}) : super(key: key);

  @override
  _ManageRegionsPageState createState() => _ManageRegionsPageState();
}


class _ManageRegionsPageState extends State<ManageRegionsPage> {
   List regions = ["Constantine", "Setif", "Batna", "Algiers"];

   void initState() {
     super.initState();

     getregions();
   }

   Future<void> getregions() async {
    var response = await http.get(Uri.parse(
        "http://192.168.56.1/damproject/getRegions.php"));
    if (response.statusCode == 200) {
      setState(() {
        regions = jsonDecode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
/*
  void addRegion(String name) {
    setState(() {
      regions.add(name);
    });
  }*/

  Future<void> deleteRegion(String region) async{
    var response = await http.get(Uri.parse(
        "http://192.168.56.1/damproject/deleteRegion.php?region=$region"));
    if (response.statusCode == 200) {
      setState(() {
        print('meow');
        getregions();

      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Manage Regions',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: regions.length,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(LineAwesomeIcons.map_marker, color: Colors.grey),
              title: Text(
                regions[index],
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                icon: const Icon(LineAwesomeIcons.alternate_trash, color: Colors.redAccent),
                onPressed: () => deleteRegion(regions[index]),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final controller = TextEditingController();
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                  'Add Region',
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                content: TextField(
                  controller: controller,
                  style: GoogleFonts.poppins(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF8F5F2),
                    hintText: 'Region Name',
                    hintStyle: GoogleFonts.poppins(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                       // addRegion(controller.text);
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Add',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(color: Colors.redAccent),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(LineAwesomeIcons.plus, color: Colors.black),
      ),
    );
  }
}
