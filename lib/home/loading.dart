import 'package:flutter/material.dart';
import 'package:leia/home/home.dart';
import 'dart:async';
import 'package:loading_btn/loading_btn.dart';

class Loading extends StatefulWidget {
  const Loading({
    super.key,
  });

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
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
                      image: AssetImage('assets/home/background.jpeg'),
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
                        const Color(0xFF5E8FEE).withOpacity(0.1),
                        const Color(0xFF38B49A).withOpacity(0.7),
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
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.7),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 100,
                            backgroundImage:
                                AssetImage('assets/home/logo.jpeg'),
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Last Step!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3A65B7),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "According to your interests I am\nanalyzing the best route of exit for\nYOU.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 85),
                      // Animated Button
                      LoadingBtn(
                        height: 60,
                        minWidth: 100,
                        borderRadius: 30,
                        animate: true,
                        color: Color(0xFF38B49A),
                        width: MediaQuery.of(context).size.width * 0.45,
                        loader: Container(
                          padding: const EdgeInsets.all(10),
                          width: 40,
                          height: 40,
                          child: const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        child: const Text('Get Started',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        onTap: (startLoading, stopLoading, btnState) async {
                          if (btnState == ButtonState.idle) {
                            startLoading();
                            // call your network api
                            await Future.delayed(const Duration(seconds: 15));
                            stopLoading();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ));
                          }
                        },
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
