import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../constants/images_strings.dart';
import '../../constants/size.dart';
import '../../constants/text.dart';
import '../dashboard/homepage.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(defaultsize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: AssetImage(Logo), height: size.height * 0.2),
              Text(
                welcome,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                welcomesub,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Loginform(),
            ],
          ),
        ),
      ),
    );
  }
}

class Loginform extends StatelessWidget {
  const Loginform({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(LineAwesomeIcons.envelope),
                labelText: temail,
                hintText: temail,
                labelStyle: GoogleFonts.poppins(),
                hintStyle: GoogleFonts.poppins(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 17),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(LineAwesomeIcons.fingerprint),
                labelText: tpassword,
                hintText: tpassword,
                labelStyle: GoogleFonts.poppins(),
                hintStyle: GoogleFonts.poppins(),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: const Icon(LineAwesomeIcons.eye_1),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>AdminDashboard()),
                );},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "LOGIN",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
