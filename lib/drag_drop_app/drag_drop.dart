import 'package:flutter/material.dart';


class PhysicsDragDropApp extends StatelessWidget {
  const PhysicsDragDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Physics Drag & Drop',
      debugShowCheckedModeBanner: false,
      home: const DragDropScreen(),
    );
  }
}

class DragDropScreen extends StatefulWidget {
  const DragDropScreen({super.key});

  @override
  State<DragDropScreen> createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  // لتتبع الكور اللي اتسحبت بنجاح
  final Map<Color, bool> matched = {
    Colors.red: false,
    Colors.green: false,
    Colors.blue: false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Physics Drag & Drop")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // --- الكور (Draggable) ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: matched.keys.map((color) {
              return matched[color] == true
                  ? const SizedBox(width: 70, height: 70) // اختفت بعد النجاح
                  : Draggable<Color>(
                      data: color,
                      feedback: BallWidget(color: color, radius: 35, opacity: 0.7),
                      childWhenDragging:
                          BallWidget(color: color.withOpacity(0.3), radius: 35),
                      child: BallWidget(color: color, radius: 35),
                    );
            }).toList(),
          ),

          const SizedBox(height: 50),

          // --- الحاويات (DragTarget) ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: matched.keys.map((color) {
              return DragTarget<Color>(
                builder: (context, candidateData, rejectedData) {
                  bool isActive = candidateData.isNotEmpty;

                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: matched[color] == true
                          ? color.withOpacity(0.8) // صح
                          : isActive
                              ? Colors.grey[300] // لما الكورة فوقه
                              : Colors.grey[200], // الحالة العادية
                      border: Border.all(color: color, width: 3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: matched[color] == true
                          ? const Icon(Icons.check, color: Colors.white, size: 30)
                          : null,
                    ),
                  );
                },
                onWillAccept: (data) => true, // ممكن نقبل أي لون (هنشيك بعدين)
                onAccept: (data) {
                  if (data == color) {
                    setState(() {
                      matched[color] = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("✅ Matched ${colorName(color)}!")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("❌ Wrong container!")),
                    );
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String colorName(Color c) {
    if (c == Colors.red) return "Red";
    if (c == Colors.green) return "Green";
    if (c == Colors.blue) return "Blue";
    return "Unknown";
  }
}

// --- ويدجت بسيطة للكرة ---
class BallWidget extends StatelessWidget {
  final Color color;
  final double radius;
  final double opacity;

  const BallWidget({
    super.key,
    required this.color,
    required this.radius,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(2, 2),
            )
          ],
        ),
      ),
    );
  }
}
