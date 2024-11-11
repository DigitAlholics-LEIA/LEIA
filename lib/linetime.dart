import 'package:flutter/material.dart';
import 'package:leia/destinationScreen.dart';
import 'package:timeline_tile/timeline_tile.dart';

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  _JourneyScreenState createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.teal.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Your Journey',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 26, color: Colors.black87),
                    children: [
                      TextSpan(text: 'This is '),
                      TextSpan(
                        text: 'YOUR ',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                      TextSpan(text: 'journey to\n'),
                      TextSpan(
                        text: 'Software Engineering',
                        style: TextStyle(
                          color: Colors.teal.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                JourneyPath(),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: GradientButton(
                        text: 'Success Stories',
                        onPressed: () {},
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.teal],
                        ),
                        icon: Icons.star,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GradientButton(
                        text: 'Export as PDF',
                        onPressed: () {},
                        gradient: LinearGradient(
                          colors: [Colors.teal, Colors.blue],
                        ),
                        icon: Icons.picture_as_pdf,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class JourneyPath extends StatefulWidget {
  @override
  _JourneyPathState createState() => _JourneyPathState();
}

class _JourneyPathState extends State<JourneyPath> {
  final List<JourneyStep> steps = [
    JourneyStep(
      label: 'Pre-university',
      color: Colors.blue.shade700,
      icon: Icons.school,
      description: 'Foundation of your journey',
      isFirst: true,
    ),
    JourneyStep(
      label: 'Higher Education',
      color: Colors.teal.shade700,
      icon: Icons.psychology,
      description: 'Expanding your knowledge',
    ),
    JourneyStep(
      label: 'Languages',
      color: Colors.blue.shade700,
      icon: Icons.code,
      description: 'Mastering programming languages',
    ),
    JourneyStep(
      label: 'Internship',
      color: Colors.teal,
      icon: Icons.work,
      description: 'Real-world experience',
    ),
    JourneyStep(
      label: 'Extracurriculars',
      color: Colors.teal,
      icon: Icons.extension,
      description: 'Beyond the classroom',
    ),
    JourneyStep(
      label: 'Work Life',
      color: Colors.blue,
      icon: Icons.business_center,
      description: 'Professional development',
    ),
    JourneyStep(
      label: 'Specialization',
      color: Colors.blue,
      icon: Icons.emoji_events,
      description: 'Mastering your craft',
      isLast: true,
    ),
  ];

  // Lista para almacenar si un paso fue completado o no
  late List<bool> stepCompleted;

  @override
  void initState() {
    super.initState();
    // Inicializamos cada paso como no completado (false)
    stepCompleted = List<bool>.filled(steps.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: steps.asMap().entries.map((entry) {
            int index = entry.key;
            JourneyStep step = entry.value;

            return JourneyTile(
              label: step.label,
              color: stepCompleted[index] ? Colors.green : step.color,
              isFirst: step.isFirst,
              isLast: step.isLast,
              icon: step.icon,
              description: step.description,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DestinationScreen(step.label),
                  ),
                ).then((_) {
                  // Al regresar de la pantalla, marcamos el paso como completado
                  setState(() {
                    stepCompleted[index] = true;
                  });
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class JourneyStep {
  final String label;
  final Color color;
  final IconData icon;
  final String description;
  final bool isFirst;
  final bool isLast;

  JourneyStep({
    required this.label,
    required this.color,
    required this.icon,
    required this.description,
    this.isFirst = false,
    this.isLast = false,
  });
}

class JourneyTile extends StatefulWidget {
  final String label;
  final Color color;
  final bool isFirst;
  final bool isLast;
  final IconData icon;
  final String description;
  final VoidCallback onPressed; // Nuevo parámetro para la acción al presionar

  const JourneyTile({
    required this.label,
    required this.color,
    this.isFirst = false,
    this.isLast = false,
    required this.icon,
    required this.description,
    required this.onPressed, // Asegúrate de que sea obligatorio
  });

  @override
  _JourneyTileState createState() => _JourneyTileState();
}

class _JourneyTileState extends State<JourneyTile>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  AnimationController? _controller;
  Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _toggleHalo() {
    setState(() {
      _isPressed = !_isPressed;
      if (_isPressed) {
        _controller?.forward();
      } else {
        _controller?.reverse();
      }
      widget.onPressed(); // Llama la función de navegación
    });
  }

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: widget.isFirst,
      isLast: widget.isLast,
      beforeLineStyle: LineStyle(
        color: widget.color.withOpacity(0.6),
        thickness: 6,
      ),
      afterLineStyle: LineStyle(
        color: widget.color.withOpacity(0.6),
        thickness: 6,
      ),
      indicatorStyle: IndicatorStyle(
        width: 60,
        height: 60,
        indicator: GestureDetector(
          onTap: _toggleHalo,
          child: ScaleTransition(
            scale: _scaleAnimation ?? const AlwaysStoppedAnimation(1.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    widget.color.withOpacity(0.9),
                    widget.color.withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: _isPressed
                    ? [
                        BoxShadow(
                          color: widget.color.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 15,
                        ),
                        BoxShadow(
                          color: widget.color.withOpacity(0.2),
                          spreadRadius: 20,
                          blurRadius: 30,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: widget.color.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
              ),
              child: Center(
                child: Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
      endChild: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: widget.color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.description,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Gradient gradient;
  final IconData icon;

  const GradientButton({
    required this.text,
    required this.onPressed,
    required this.gradient,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onPressed,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
