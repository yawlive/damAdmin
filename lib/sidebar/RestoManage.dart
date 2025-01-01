import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageRestaurantsPage extends StatefulWidget {
  const ManageRestaurantsPage({Key? key}) : super(key: key);

  @override
  _ManageRestaurantsPageState createState() => _ManageRestaurantsPageState();
}

class _ManageRestaurantsPageState extends State<ManageRestaurantsPage> {

  //List restaurants=[];
  @override
  void initState() {
    super.initState();

    fetchRestaurants();
  }


   List restaurants = [
    {
      "RestaurantName": "Magic House",
      "RegionName": "Constantine",
      "Description": "A cozy place for family dining.",
      "ImageURL": "https://via.placeholder.com/150",
      "rating": 4.5
    },
     {
       "RestaurantName": "Magic House",
       "RegionName": "Constantine",
       "Description": "A cozy place for family dining.",
       "ImageURL": "https://via.placeholder.com/150",
       "rating": 4.5
     },
  ];




  Future<void> fetchRestaurants() async {

    var response = await http.get(Uri.parse(
        "http://192.168.56.1/damproject/getAllRestaurants.php"));

    if (response.statusCode == 200) {
      setState(() {

      restaurants= jsonDecode(response.body);
        print(restaurants );
      });


    } else {
      print('Request failed with status: ${response.statusCode}');
    }

  }

  Future<void> addRestaurant(
      String name,
      String phone,
      String region,
      String location,
      String description,
      String imageURL,
      String openingTime,
      String closingTime,
      String priceRange,
      ) async {
    final url = Uri.parse('http://192.168.56.1/damproject/addRestaurant.php');

    try {
      final response = await http.post(
        url,
        body: {
          'RestaurantName': name,
          'Phone': phone,
          'RegionName': region,
          'Location': location,
          'Description': description,
          'ImageURL': imageURL,
          'OpeningTime': openingTime,
          'ClosingTime': closingTime,
          'PriceRange': priceRange,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['message'] == 'Restaurant added successfully') {
          print('Restaurant added successfully');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('mafihach1')));
        } else {
          print('Error: ${jsonResponse['message']}');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('mafihach2')));
        }
      } else {
        print('Server error: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('mafihach3')));
      }
    } catch (e) {
      print('Error: $e');

    }
  }


  Future <void> deleteRestaurant(int RestaurantID) async{
       var response = await http.get(Uri.parse('http://192.168.56.1/damproject/deleteRestaurant.php?RestaurantId=$RestaurantID'));
       if(response.statusCode==200){
         setState(() {
           fetchRestaurants();
          });
  }else{

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.body)));

  }


}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Manage Restaurants',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  restaurant["ImageURL"],
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                restaurant["RestaurantName"],
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Region: ${restaurant["RegionName"]}',
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                  ),
                  Text(
                    restaurant["Description"],
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 5),
                  RatingBarIndicator(
                    rating: double.parse(restaurant["rating"]),
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                    itemSize: 20,
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteRestaurant(restaurant['RestaurantID']),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE8E8E8),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final nameController = TextEditingController();
              final regionController = TextEditingController();
              final descriptionController = TextEditingController();
              final imageController = TextEditingController();
              final phoneController = TextEditingController();
              final openingTimeController = TextEditingController();
              final closingTimeController = TextEditingController();
              final locationController = TextEditingController();
              final priceRangeController = TextEditingController();

              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                  'Add Restaurant',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Restaurant Name',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: regionController,
                        decoration: InputDecoration(
                          labelText: 'Region',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: locationController,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: imageController,
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: openingTimeController,
                        decoration: InputDecoration(
                          labelText: 'Opening Time',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: closingTimeController,
                        decoration: InputDecoration(
                          labelText: 'Closing Time',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: priceRangeController,
                        decoration: InputDecoration(
                          labelText: 'Price Range',
                          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(color: Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty &&
                          regionController.text.isNotEmpty &&
                          locationController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty &&
                          imageController.text.isNotEmpty &&
                          openingTimeController.text.isNotEmpty &&
                          closingTimeController.text.isNotEmpty &&
                          priceRangeController.text.isNotEmpty) {
                        addRestaurant(
                          nameController.text,
                          phoneController.text,
                          regionController.text,
                          locationController.text,
                          descriptionController.text,
                          imageController.text,
                          openingTimeController.text,
                          closingTimeController.text,
                          priceRangeController.text,
                        );
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Add',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },

        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
