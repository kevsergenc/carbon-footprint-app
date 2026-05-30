import 'package:carbon_footprint_app/result_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SurveyPage extends StatefulWidget{
  const SurveyPage ({super.key});
   @override
  State<SurveyPage> createState() => _SurveyPageState();
}
 class _SurveyPageState extends State<SurveyPage> {
  final Map<String, bool> expandedCategories={
    "Ulaşım":true,
    "Beslenme": false,
    "Enerji": false,
    "Geri Dönüşüm": false,
    "Su Tüketimi": false,
  };
  final Map<String, String> selectedAnswers ={};
  Future<void> saveSurveyAnswers() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) return;

  await FirebaseFirestore.instance.collection('survey_answers').add({
    'uid': user.uid,
    'answers': selectedAnswers,
    'createdAt': Timestamp.now(),
  });
}
  final List<Map<String, dynamic>> categories= [
    {
      "title":"Ulaşım",
      "subtitle":"Günlük Ulaşım alışkanlıklarınızı analiz edin.",
      "icon": Icons.directions_car,
      "questions": [
        {
          "question": "Günlük ulaşım tercihiniz nedir?",
          "options": [ "Özel araç", "Toplu taşıma", "Elektrikli araç", "Bisiklet/Yürüyüş"],
        },
        {
          "question": "Günlük ortalama kaç km yol katediyorsunuz?",
          "options": ["0-50 km", "51-100 km","101-200 km","200+ km"]
        },
    {
      "question": "Aracınızın yakıt türü nedir?",
      "options": [ "Benzin", "Dizel","LPG", "Elektrik/Hibrit"]

    },
  ],
    },
    {
      "title": "Beslenme",
      "subtitle": "Beslenme alışkanlıklarınızı değerlendirin.",
      "icon":Icons.eco,
      "questions": [
        {
          "question":"Beslenme düzeniniz nasıl?",
          "options":["Et ağırlıklı", "Karışık", "Vejetaryen","Vegan"]
        },
        {
          "question":"Haftada kaç kez kırmızı et tüketiyorsunuz?",
          "options":["0-1 kez", "2-3 kez", "4-5 kez", "5+ kez"]
        },
        {
          "question":"Yemeklerinizi genellikle nerede yersiniz?",
          "options": ["Evde", "Restoranda", "Dışarıda/Paket", "Karışık"]

        },
        {
         "question":"Yerel ve mevsimsel ürünleri tercih eder misiniz?",
      "options":["Evet","Bazen","Nadiren","Hayır"] 
        },
          ],
    },
           

      
        
 {
  "title":"Enerji",
      "subtitle":"Evdeki enerji kullanımınızı inceleyin.",
      "icon": Icons.bolt,
      "questions":[
        {
          "question":"Evinizin ısınma yöntemi nedir?",
      "options":["Doğalgaz", "Elektrik","Kömür/Odun","Isı pompası"]
        },
        {
          "question": "Haftalık enerji tüketiminizi nasıl değerlendirirsiniz?",
          "options": ["Düşük", "Orta", "Yüksek"]
        },
        {
         "question": "Elektronik cihazlarınızı kullanılmadığında kapatır mısınız?",
          "options":  ["Her zaman", "Bazen", "Nadiren", "Hayır"]
        },
        {
          "question": "Enerji tasarruflu ampul kullanıyor musunuz?",
          "options":[ "Evet","Kısmen", "Hayır"]
        },
        {
          "question": "Klima kullanım sıklığınız nedir?",
          "options":["Nadiren","Bazen","Sık sık","Her gün"]
        },
      ],
      },
      {
        "title":"Geri dönüşüm",
        "subtitle": "Atık yönetimi alışkanlıklarınızı gözden geçirin.",
        "icon":Icons.recycling,
        "questions":[
          {
            "question":"Atıklarınızı geri dönüştürüyor musunuz?",
            "options": ["Evet, düzenli olarak","Bazen","Hayır"]
          },
          {
            "question":"Alışveriş yaparken nelere dikkat edersiniz?",
            "options":["Yerel ürünler","İndirim/Fiyat","Marka","Dikkat etmiyorum"]
          },
        ],
      },
      {
         "title":"Su Tüketimi",
        "subtitle": "Su kullanım alışkanlıklarınızı değerlendirin.",
        "icon":Icons.water_drop,
        "questions":[
          {"question": "Duş süreniz genellikle ne kadardır?",
          "options":[
           "5 dakikadan az", "5-10 dakika", "10-20 dakika" , "20 dakikadan fazla"]
          },
          {
            "question": "Çamaşır makinesini haftada kaç kez kullanıyorsunuz?",
          "options": ["1-2 kez", "3-4 kez", "5+ kez"]
          },
        ],
      },
  ];
    
      
      int get totalQuestions {
        int count=0;
        for( var category in categories) {
          count += (category["questions"]as List).length;

        }
        return count;
      }
  
      int get answeredQuestions => selectedAnswers.length;

      double get progress => totalQuestions == 0?0 : answeredQuestions/totalQuestions;

      @override
      Widget build (BuildContext context){
        return Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            backgroundColor: const Color(0xFF1B5E20),
            elevation: 0,
            centerTitle: true,
            title: const Text("Karbon Ayak İzi Anketi",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,

            ),
            ),
            iconTheme:  const IconThemeData(color: Colors.white),
          ),
          body: Stack(
            children: [
              Positioned.fill(child: Image.asset("assets/images/soft.jpg",
              fit: BoxFit.cover,
              ),
              ),
              Positioned.fill(
                child:Container(
                  color: Colors.white.withOpacity(0.80),
                ),
                 ),
                 SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column (
                    children: [
                      _buildHeaderCard(),
                      const SizedBox( height: 18),

                      for (var category in categories)
                      _buildCategoryCard(category),
                      const SizedBox(height: 18),
                      _buildResultButton(),
                    ],
                    ),

                 ),
            ],
          ),
        );
      }
      Widget _buildHeaderCard(){
        return Container(
          padding:  const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.90),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.grey.shade200),

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Alışkanlıklarınızı analiz edelim",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF123D2A),

              ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Her kategorideki soruları yanıtlayarak karbon ayak izinizi hesaplayınız.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              Text( "Genel İlerleme ${(progress * 100).toInt()}%",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),

              ),
              ),
              const SizedBox(height:8),
              LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFE0E0E0),
              color: const Color(0xFF2E7D32),
              borderRadius:BorderRadius.circular(20),
          
          ),
          const SizedBox(height:8),
          Text("$answeredQuestions/ $totalQuestions  soru tamamlandı",
          style:const TextStyle(
            fontSize:12,
            color: Colors.black54,
          ),
          ),
            ],
          ),
        );
      }
      Widget _buildCategoryCard(Map<String,dynamic> category){
        final String title =category["title"];
        final bool isExpanded= expandedCategories[title]?? false;
        final List questions = category["questions"];
        return Container(
          margin: const EdgeInsets.only(bottom:14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color:Colors.grey.shade200),
          ),
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: (){
                  setState((){
                    expandedCategories[title]=!isExpanded;

                  });
                },
                child: Padding(padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFFEAF3E7),
                      child: Icon(
                        category["icon"],
                        color: const Color(0xFF2E7D32),

                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(child: Text(
                      title,
                      style:  const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF123D2A),

                      ),
                    ),
                    ),
                    Text(
                      "${questions.length} soru",
                      style: const TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                    color: const Color (0xFF123D2A),
                    ),
                  ],
                ),
              ),
              ),
              if(isExpanded)
              Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
              child: Column(children: [
                for (int i= 0; i<questions.length; i++)
                _buildQuestion(
                  categoryTitle: title,
                  questionIndex: i + 1,
                 question: questions[i]["question"],
                 options: List<String>.from(questions[i]["options"]),

                ),
              ],
              ),
              ),
            ],
            ),
        );
        
        
      }

      Widget _buildQuestion({
        required String categoryTitle,
        required int questionIndex,
        required String question,
        required List<String> options,

      }) {
        final String questionKey = "$categoryTitle-$questionIndex";
        return Padding(padding: const EdgeInsets.only(top:14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: const Color(0xFFEAF3E7),
                child: Text(
                  "$questionIndex",
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,

                  ),
                ),
              
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(
                question,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,

                ),
              ),
              ),
            ],
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: options.map((option){
                final bool selected = selectedAnswers[questionKey] == option;

                return GestureDetector(
                  onTap:( ){
                    setState(() {
                      selectedAnswers[questionKey]=option;
                    });
                  },
                  child: Container(
                    width:MediaQuery.of(context).size.width * 0.40 ,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical:12),
                    decoration: BoxDecoration(
                      color: selected
                      ? const Color(0xFFF2F8EF)
                      : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                        ? const Color(0xFF2E7D32)
                        : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(children: [
                      Icon(
                        selected
                        ?Icons.radio_button_checked
                        :Icons.radio_button_off,
                        size:18,
                        color: selected
                        ?const Color(0xFF2E7D32)
                        : Colors.grey,
                      ),
                      const SizedBox(width:6),
                      Expanded(child: Text(
                        option,
                        style: const TextStyle(fontSize: 12.5,
                        ),
                      ),
                      ),
                    ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        );
      }
      Widget _buildResultButton(){
        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(22),


          ),
          child: Column(
            children: [
              const Text(
                "Sonucu Görmeye Hazır Mısın?",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF123D2A),

                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
  await saveSurveyAnswers();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultPage(),
    ),
  );
},
                  child: const Text(
                    "Sonucu Hesapla",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }
 }