import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool showSuggestions = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F4),
      appBar: AppBar(
        title: const Text("Karbon Ayak İzi Sonucunuz"),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              title: "Karbon Ayak İziniz",
              maxLines:4,
            ),
            const SizedBox(height: 20),

            _buildTextField(
            title: "Karbon Ayak İzi Miktarı",
            maxLines: 4),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E20),

                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    showSuggestions = !showSuggestions;
                  });
                },
                icon: const Icon(
                  Icons.eco,
                  color: Colors.white,

                ),
                label: const Text("Sürdürülebilirlik Önerileri",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                ),
              ),
            ),
            if(showSuggestions)...[
              const SizedBox(height: 24),
              _buildTextField(
                title: "",
                maxLines:6
              ),
            ],
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
  Widget _buildTextField({
    required String title,
    required int maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Color(0xFF123D2A),
          ),
        ),
        const SizedBox(height: 10),

        TextField(
          maxLines: maxLines,
decoration: InputDecoration(
        filled:true,
        fillColor:Colors.white,
        contentPadding: const EdgeInsets.all(18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFF1B5E20),
            width: 2,
          ),
        ),
),
          ),
        
      ],
    );
  }
}