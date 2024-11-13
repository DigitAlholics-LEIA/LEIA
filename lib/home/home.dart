import 'package:flutter/material.dart';
import 'package:leia/home/loading.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Stack(
            children: [
              ClipPath(
                clipper: CurvedClipper(),
                child: Container(
                  height: 500,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                      AssetImage('assets/home/background.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ClipPath(
                clipper: CurvedClipper(),
                child: Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF5E8FEE)
                            .withOpacity(0.1),
                        const Color(0xFF38B49A)
                            .withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 150),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape
                                .circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.7),
                                spreadRadius:
                                3,
                                blurRadius: 10,
                                offset:
                                Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 100,
                            backgroundImage: AssetImage(
                                'assets/home/logo.jpeg'),
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Welcome to your Virtual\nSuccess Career Advisor!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3A65B7), // Aquí se agrega el color

                        ),
                      ),
                      SizedBox(height: 30),
                      const Text(
                        "I'm here to guide you in discovering\nyour true potential and selecting\nthe perfect path that aligns with\nyour aspirations.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16, 
                          color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 85),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Loading(),
                              ));
                          // Acción a realizar al presionar el botón
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 100),
                          backgroundColor: Color(0xFF38B49A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(-45, size.height * 0.2);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width + 40, size.height * 0.2);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}