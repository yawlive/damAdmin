import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageReviewsPage extends StatefulWidget {
  const ManageReviewsPage({Key? key}) : super(key: key);

  @override
  _ManageReviewsPageState createState() => _ManageReviewsPageState();
}
class _ManageReviewsPageState extends State<ManageReviewsPage> {
  void initState() {
    super.initState();

    getcomments();
  }

  Future<void> getcomments() async{
      var response = await http.get(Uri.parse('http://192.168.56.1/damproject/getReviews.php'));
      if(response.statusCode==200){
        setState(() {

          reviews=jsonDecode(response.body);
        });
      }
}

   List reviews = [
    {
      "username": "Norhane",
      "Review": 4.5,
      "CommentText": "Great food and ambiance!",
      "RestaurantName": "Magic House",
      "CommentDate": DateTime.now().subtract(Duration(days: 1)),
    },

  ];

  String? selectedRestaurant;
  double? minRating;

  Future<void> deleteReview(String commentid) async{
    var response = await http.get(Uri.parse('http://192.168.56.1/damproject/deleteComment.php?CommentID=$commentid'));
    if( response.statusCode==200){
      print('were inside ');
      setState(() {
        getcomments();
      });
    }
  }

  List get filteredReviews {
    return reviews.where((review) {
      final matchesRestaurant = selectedRestaurant == null ||
          review["RestaurantName"] == selectedRestaurant;
      final matchesRating = minRating == null || double.parse(review["Review"]) >= minRating!;
      return matchesRestaurant && matchesRating;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text(
          'Manage Reviews',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                if (value == "4+ Stars") {
                  minRating = 4.0;
                } else {
                  minRating = null;
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "All", child: Text("All Reviews")),
              const PopupMenuItem(value: "4+ Stars", child: Text("4+ Stars")),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            hint: Text("Filter by Restaurant", style: GoogleFonts.poppins()),
            value: selectedRestaurant,
            onChanged: (value) {
              setState(() {
                selectedRestaurant = value;
              });
            },
            items: reviews
                .map<String>((review) => review["RestaurantName"] as String)
                .toSet()
                .map<DropdownMenuItem<String>>((restaurant) => DropdownMenuItem<String>(
              value: restaurant,
              child: Text(restaurant, style: GoogleFonts.poppins()),
            ))
                .toList(),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredReviews.length,
              itemBuilder: (context, index) {
                final review = filteredReviews[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      "${review["username"]} - ${review["RestaurantName"]}",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBarIndicator(
                          rating: double.parse(review["Review"]),
                          itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                          itemSize: 20.0,
                        ),
                        Text(
                          review["CommentText"],
                          style: GoogleFonts.poppins(),
                        ),
                        Text(
                          "Date: ${review["CommentDate"].toString().split(" ")[0]}",
                          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteReview(review['CommentID']),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
